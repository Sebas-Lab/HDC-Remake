import 'package:hdc_remake/screens/settings_screen/settings_screen_dependencies.dart';
import 'package:hdc_remake/models/songbooks.dart';
import '../../../application_themes.dart';
import '../../../global_data/download_dialog.dart';
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
    List<Hymn> hymns = await DatabaseHelper.instance.getHymnsBySongbookId(hymnbookId);

    // Actualiza el valor de hymnsNotifier
    hymnsNotifier.value = List<Hymn>.from(hymns);

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

    Navigator.of(context).pop();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: getDialogBGColor(context),
          title: Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Center(
              child: Text(
                  'Descargando himnario',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: getDialogTextColor(context),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularProgressIndicator(
                      color: getDialogTextColor(context),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Text(
                        songbook.name,
                        style: TextStyle(
                          color: getDialogTextColor(context),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    // Obtén los himnos del himnario desde el servidor/API
    List<Hymn> hymns = await fetchSongbookData(songbook.id);

    // Guarda los himnos en la base de datos local
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    await Future.forEach(hymns, (Hymn hymn) async {
      await dbHelper.insert(Hymn(
        id: hymn.id,
        name: hymn.name,
        lyrics: hymn.lyrics,
        songbookId: songbook.id,
        audioURL: hymn.audioURL,
      ));
    });

    // Aquí actualizamos la lista de himnos en memoria
    hymnsNotifier.value = List<Hymn>.from(hymns);

    SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager();
    await sharedPreferencesManager.saveSelectedHymnbookId(songbook.id);
    await sharedPreferencesManager.saveHymnbookVersion(songbook.version); // Save hymnbook version
    totalHymns.value = hymns.length;
    await sharedPreferencesManager.saveDownloadedSongbook(songbook.id);
    await sharedPreferencesManager.saveTotalHymns(totalHymns.value);
    sharedPreferencesManager.selectedHymnbookIdNotifier.value = songbook.id;
    Navigator.of(context).pop();
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
              title: Text(
                'Himnario seleccionado',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getDialogTextColor(context),
                ),
              ),
              content: Text(
                'Este es el himnario que estás usando actualmente.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getDialogTextColor(context),
                ),
              ),
              backgroundColor: getDialogBGColor(context),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Text(
                      'Aceptar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getDialogTextColor(context),
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
              title: Text(
                'Cambiar himnario',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getDialogTextColor(context),
                )
              ),
              content: Text(
                'Cambiar tu himnario actual por ${songbook.name}?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getDialogTextColor(context),
                ),
              ),
              backgroundColor: getDialogBGColor(context),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: getDialogTextColor(context),
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
                    child: Text(
                      'Cambiar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getDialogTextColor(context),
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
              title: Text(
                'Descargar himnario',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getDialogTextColor(context),
                ),
              ),
              content: Text(
                '¿Deseas descargar este himnario?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getDialogTextColor(context),
                ),
              ),
              backgroundColor: getDialogBGColor(context),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: getDialogTextColor(context),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await downloadHymnsForSongbook(songbook);
                    totalHymns.value = songbook.songAmount;
                    await updateSongbooksDownloadStatus(songbooks);
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Text(
                      'Descargar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getDialogTextColor(context),
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al obtener los himnarios'));
          } else {
            songbooks = snapshot.data!;

            return FutureBuilder<int?>(
              future: getSelectedSongbookId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
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
                              color: getContainerColor(context),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.7),
                                  blurRadius: getBlurContainer(context),
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
                                    songbook.name,
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                      color: getTextColor(context),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: getDividerColor(context),
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
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: getTextColor(context),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 30.0, top: 10.0),
                                      child: Icon(
                                        getIconData(songbook, isSelected),
                                        color: getIconsColors(context),
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

  Color getDialogBGColor(BuildContext context) {

    var themeData = Theme.of(context);

    if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
      return const Color(0xFF1E2A47);
    } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
      return const Color(0xFFC5CAE9);
    } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
      return const Color(0xFF3C3C3C);
    }

    return Colors.white;
  }

  Color getDialogTextColor(BuildContext context) {

    var themeData = Theme.of(context);

    if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
      return Colors.white;
    } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
      return const Color(0xFF3A3A3A);
    } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
      return Colors.white;
    }

    return Colors.white;
  }

  Color getContainerColor(BuildContext context) {

    var themeData = Theme.of(context);

    if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
      return const Color(0xFF1E2A47);
    } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
      return const Color(0xFF87CEEB);
    } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
      return const Color(0xFF3C3C3C);
    }

    return Colors.white;
  }

  Color getTextColor(BuildContext context) {

    var themeData = Theme.of(context);

    if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
      return Colors.white;
    } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
      return const Color(0xFF3A3A3A);
    } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
      return Colors.white;
    }

    return Colors.white;
  }

  Color getDividerColor(BuildContext context) {

    var themeData = Theme.of(context);

    if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
      return const Color(0xFF3DBAA6);
    } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
      return const Color(0xFF009BFF);
    } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
      return Colors.white;
    }

    return Colors.white;
  }

  Color getIconsColors(BuildContext context) {

    var themeData = Theme.of(context);

    if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
      return const Color(0xFF3DBAA6);
    } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
      return const Color(0xFF009BFF);
    } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
      return Colors.white;
    }

    return Colors.white;
  }

  double getBlurContainer(BuildContext context) {

    var themeData = Theme.of(context);

    if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
      return 15;
    } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
      return 15;
    } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
      return 5;
    }

    return 10;
  }
}
