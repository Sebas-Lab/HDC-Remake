import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

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
                    onHymnbookChanged(songbook.id, totalHymns.value, () => {setState((){})});
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
                    await downloadHymnsForSongbook(songbook, context);
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
