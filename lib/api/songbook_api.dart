import 'package:hdc_remake/application_dependencies/app_dependencies.dart';
import 'package:hdc_remake/models/songbooks.dart';
import 'package:http/http.dart' as http;

import '../global_data/total_hymns.dart';

ValueNotifier<List<Hymn>> hymnsNotifier = ValueNotifier([]);

Future<List<Songbook>> fetchSongs() async {

  final response = await http.get(Uri.parse('http://himnariodev.bibliayopinion.com/api/getSongsbooks'));
  final jsonResponse = jsonDecode(response.body);

  if (jsonResponse['success'] == true) {

    final jsonResponse = jsonDecode(response.body);
    final List<dynamic> data = jsonResponse['data'];
    final List<Songbook> songbook = data.map((json) => Songbook.fromJson(json)).toList();
    return songbook;

  } else {
    print('Error al conectar con el servidor. Código de estado: ${response.statusCode}');
    return [];
  }
}

Future<List<SongBooks>> fetchSongBooks() async {
  final response = await http.get(Uri.parse('http://himnariodev.bibliayopinion.com/api/getSongsbooks'));
  final jsonResponse = jsonDecode(response.body);

  if (jsonResponse['success'] == true) {
    final jsonResponse = jsonDecode(response.body);
    final List<dynamic> data = jsonResponse['data'];
    final List<SongBooks> songbooks = data.map((json) => SongBooks.fromJson(json)).toList();
    return songbooks;
  } else {
    print('Error al conectar con el servidor. Código de estado: ${response.statusCode}');
    return [];
  }
}

Future<List<Hymn>> fetchSongbookData(int songbookId) async {
  final response = await http.get(Uri.parse('http://himnariodev.bibliayopinion.com/api/getSongsBySongsbooks/$songbookId'));
  final jsonResponse = jsonDecode(response.body);

  if (jsonResponse['success'] == true) {
    final List<dynamic> data = jsonResponse['data'];
    final List<Hymn> hymns = data.map((json) => Hymn.fromMap(json)).toList();

    return hymns;
  } else {
    print('Error al conectar con el servidor. Código de estado: ${response.statusCode}');
    return [];
  }
}

Future<void> downloadHymns(int songbookId, GlobalKey<ScaffoldState> scaffoldKey, List<Songbook> songbooks) async {
  Songbook selectedSongbook = songbooks.firstWhere((songbook) => songbook.id == songbookId);
  showDialog(
    context: scaffoldKey.currentContext!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Center(
            child: Text('Descargando himnario', textAlign: TextAlign.center),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CircularProgressIndicator(),
                  Text('Descargando...'),
                ],
              ),
            ),
            // if (showButton)
            //   ElevatedButton(
            //     onPressed: () {
            //       timer?.cancel();
            //       Navigator.of(context).pop();
            //     },
            //     style: TextButton.styleFrom(
            //       backgroundColor: Colors.red,
            //       textStyle: const TextStyle(
            //         color: Colors.white,
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     child: const Text('Cancelar'),
            //   ),
          ],
        ),
      );
    },
  );
  // popupLogic?.showDownloadingDialog(context, "Descargando ${selectedSongbook.name}", true);
  List<Hymn> fetchedHymns = await fetchSongbookData(selectedSongbook.id);
  await DatabaseHelper.instance.deleteHymnsBySongbookId(songbookId);
  hymnsNotifier.value = List<Hymn>.from(fetchedHymns);
  SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager();
  await sharedPreferencesManager.saveHymnbookVersion(selectedSongbook.version); // Save hymnbook version

  DatabaseHelper dbHelper = DatabaseHelper.instance;
  await Future.forEach(fetchedHymns, (Hymn hymn) async {
    await dbHelper.insert(Hymn(
      id: hymn.id,
      name: hymn.name,
      lyrics: hymn.lyrics,
      songbookId: selectedSongbook.id,
    ));
  });

  await sharedPreferencesManager.saveSelectedHymnbookId(selectedSongbook.id);
  await sharedPreferencesManager.saveHymnbookVersion(selectedSongbook.version); // Save hymnbook version
  Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext!, '/home', (route) => false);
  totalHymns.value = fetchedHymns.length;
  await sharedPreferencesManager.saveDownloadedSongbook(selectedSongbook.id);
}