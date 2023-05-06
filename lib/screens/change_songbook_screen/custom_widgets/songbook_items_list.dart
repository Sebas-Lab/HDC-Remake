import 'package:hdc_remake/screens/settings_screen/settings_screen_dependencies.dart';
import 'package:hdc_remake/models/songbooks.dart';

import '../../../global_data/total_hymns.dart';

class BuildSongBookItemList extends StatefulWidget {
  const BuildSongBookItemList({Key? key}) : super(key: key);

  @override
  State<BuildSongBookItemList> createState() => _BuildSongBookItemListState();
}

class _BuildSongBookItemListState extends State<BuildSongBookItemList> {

  List<SongBooks> songbooks = [];

  Future<void> downloadHymnsForSongbook(SongBooks songbook) async {
    // Obtén los himnos del himnario desde el servidor/API
    List<Hymn> hymns = await fetchSongbookData(songbook.id);

    // Guarda los himnos en la base de datos local
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    for (Hymn hymn in hymns) {
      int uniqueId = int.parse('${songbook.id}${hymn.id}');
      print('Inserting hymn with uniqueId: $uniqueId');
      await dbHelper.insert(Hymn(
        id: uniqueId,
        name: hymn.name,
        lyrics: hymn.lyrics,
        songbookId: songbook.id,
      ));
    }
    print('downloadHymnsForSongbook: Himnos descargados: ${hymns.length}');
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
  void initState() {
    super.initState();
    updateSongbooksDownloadStatus(songbooks);
  }

  @override
  Widget build(BuildContext context) {
    return buildSongBookItemsList(context);
  }

  Widget buildSongBookItemsList(BuildContext context) {

    Future<void> onSongbookTapped(BuildContext context, SongBooks songbook) async {
      SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager();
      List<int> downloadedSongbooks = await sharedPreferencesManager.getDownloadedSongbooks();
      bool isDownloaded = downloadedSongbooks.contains(songbook.id);

      if (isDownloaded) {
        await sharedPreferencesManager.saveSelectedHymnbookId(songbook.id);
        totalHymns.value = songbook.songAmount;
        print('Himnario descargado');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Himnario seleccionado'),
              content: const Text('Este es el himnario que estás usando actualmente.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Himnario no descargado');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Descargar himnario'),
              content: const Text('¿Deseas descargar este himnario?'),
              actions: [
                TextButton(
                  onPressed: () async {
                    // Implementa la lógica de descarga aquí
                    await downloadHymnsForSongbook(songbook);
                    print('Total de himnos en songbook: ${songbook.songAmount}');
                    totalHymns.value = songbook.songAmount;
                    setState(() {});
                    await sharedPreferencesManager.saveDownloadedSongbook(songbook.id);
                    await updateSongbooksDownloadStatus(songbooks);
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: const Text('Sí'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'),
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
            return ListView.builder(
                itemCount: songbooks.length,
                itemBuilder: (context, index) {
                  SongBooks songbook = songbooks[index];
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
                                  songbook.isDownloaded ? Icons.check_box : Icons.download,
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
      ),
    );
  }
}