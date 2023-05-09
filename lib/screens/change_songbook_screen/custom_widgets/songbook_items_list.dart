import 'package:hdc_remake/screens/settings_screen/settings_screen_dependencies.dart';
import 'package:hdc_remake/models/songbooks.dart';
import '../../../global_data/total_hymns.dart';

typedef HymnbookChangedCallback = void Function(int hymnbookId, int totalHymns);

class BuildSongBookItemList extends StatefulWidget {
  final HymnbookChangedCallback onHymnbookChanged;
  const BuildSongBookItemList({Key? key, required this.onHymnbookChanged}) : super(key: key);

  @override
  State<BuildSongBookItemList> createState() => _BuildSongBookItemListState();
}

class _BuildSongBookItemListState extends State<BuildSongBookItemList> {

  List<SongBooks> songbooks = [];
  SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager();
  final GlobalKey<SongListState> songListKey = GlobalKey();

  void _onHymnbookChanged(int hymnbookId, int totalHymns) async {
    // Guarda el nuevo himnario y el número total de himnos
    await sharedPreferencesManager.saveSelectedHymnbookId(hymnbookId);
    await sharedPreferencesManager.saveTotalHymns(totalHymns);

    // Carga los nuevos himnos
    List<Hymn> hymns = await sharedPreferencesManager.loadHymns(hymnbookId);

    // Actualiza el rango de himnos
    songListKey.currentState?.applyFilter(1, hymns.length); // Asegúrate de que solo muestre 50 himnos como máximo en el primer filtro

    // Actualiza el estado para reflejar los cambios en la pantalla
    setState(() {});
  }

  IconData getIconData(SongBooks songbook, bool isSelected) {
    IconData iconData;
    if (isSelected && songbook.isDownloaded) {
      iconData = Icons.check_box; // Icono de checkbox con el check
    } else if (songbook.isDownloaded) {
      iconData = Icons.check_box_outline_blank; // Icono de checkbox sin el check
    } else {
      iconData = Icons.download; // Icono de descarga
    }
    return iconData;
  }

  Future<void> downloadHymnsForSongbook(SongBooks songbook) async {
    // Obtén los himnos del himnario desde el servidor/API
    List<Hymn> hymns = await fetchSongbookData(songbook.id);

    // Guarda los himnos en la base de datos local
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    for (Hymn hymn in hymns) {
      int uniqueId = int.parse('${songbook.id}${hymn.id}');
      await dbHelper.insert(Hymn(
        id: uniqueId,
        name: hymn.name,
        lyrics: hymn.lyrics,
        songbookId: songbook.id,
      ));
    }

    SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager();
    await sharedPreferencesManager.saveSelectedHymnbookId(songbook.id);
    await sharedPreferencesManager.saveHymnbookVersion(songbook.version); // Save hymnbook version
    totalHymns.value = hymns.length;
    await sharedPreferencesManager.saveDownloadedSongbook(songbook.id);
    await sharedPreferencesManager.saveTotalHymns(totalHymns.value);
    sharedPreferencesManager.selectedHymnbookIdNotifier.value = songbook.id;
  }

  Stream<List<SongBooks>> fetchSongbooksAndUpdateDownloadStatus() async* {
    List<SongBooks> songbooks = await fetchSongBooks();
    await updateSongbooksDownloadStatus(songbooks);
    yield songbooks;
  }

  Future<bool> isHymnbookDownloaded(int hymnbookId) async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    int hymnCount = await dbHelper.getHymnCountBySongbookId(hymnbookId);
    return hymnCount > 0;
  }

  Future<void> updateSongbooksDownloadStatus(List<SongBooks> songbooksToUpdate) async {
    for (int i = 0; i < songbooksToUpdate.length; i++) {
      bool isDownloaded = await isHymnbookDownloaded(songbooksToUpdate[i].id);
      songbooksToUpdate[i].isDownloaded = isDownloaded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildSongBookItemsList(context);
  }

  Widget buildSongBookItemsList(BuildContext context) {

    Future<int?> getSelectedSongbookId() async {
      SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager();
      return await sharedPreferencesManager.getSelectedHymnbookId();
    }

    Future<void> onSongbookTapped(BuildContext context, SongBooks songbook) async {
      SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager();
      List<int> downloadedSongbooks = await sharedPreferencesManager.getDownloadedSongbooks();
      bool isDownloaded = downloadedSongbooks.contains(songbook.id);
      int? selectedSongbookId = await getSelectedSongbookId();
      bool isSelected = songbook.id == selectedSongbookId;

      if (isDownloaded && isSelected) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Himnario seleccionado',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              content: const Text(
                'Este es el himnario que estás usando actualmente.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color(0xFF1E2A47),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Text(
                      'Aceptar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else if (isDownloaded) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Cambiar himnario',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )
              ),
              content: Text(
                'Cambiar tu himnario actual por ${songbook.name}?',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color(0xFF1E2A47),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    totalHymns.value = songbook.songAmount;
                    _onHymnbookChanged(songbook.id, totalHymns.value);
                    if (mounted) setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Text(
                      'Cambiar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Descargar himnario',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              content: const Text(
                '¿Deseas descargar este himnario?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color(0xFF1E2A47),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await downloadHymnsForSongbook(songbook);
                    totalHymns.value = songbook.songAmount;
                    setState(() {});
                    await sharedPreferencesManager.saveDownloadedSongbook(songbook.id);
                    await updateSongbooksDownloadStatus(songbooks);
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Text(
                      'Descargar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.09, left: 40, right: 40),
      child: StreamBuilder<List<SongBooks>>(
        stream: fetchSongbooksAndUpdateDownloadStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al obtener los himnarios'));
          } else {
            songbooks = snapshot.data!;

            return FutureBuilder<int?>(
              future: getSelectedSongbookId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  int selectedSongbookId = snapshot.data!;
                  return ListView.builder(
                      itemCount: songbooks.length,
                      itemBuilder: (context, index) {
                        SongBooks songbook = songbooks[index];
                        bool isSelected = songbook.id == selectedSongbookId;
                        return GestureDetector(
                          onTap: () {
                            onSongbookTapped(context,songbook);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            margin: const EdgeInsets.only(bottom: 40.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3DBAA6),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.7),
                                  blurRadius: 15,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    songbook.name, // Aquí debería ir el nombre del himnario
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3A3A3A),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 2.0,
                                  indent: 20.0,
                                  endIndent: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 20.0, top: 15.0),
                                      child: Text(
                                        'Himnos: ${songbook.songAmount}', // Aquí debería ir el número total de cada himnario
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF3A3A3A),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 30.0, top: 10.0),
                                      child: Icon(
                                        getIconData(songbook, isSelected),
                                        color: const Color(0xFF1E2A47),
                                        size: 30.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}