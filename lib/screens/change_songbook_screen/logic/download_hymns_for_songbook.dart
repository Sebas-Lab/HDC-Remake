import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

Future<void> downloadHymnsForSongbook(SongBooks songbook, BuildContext context) async {

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