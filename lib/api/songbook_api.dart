import 'package:hdc_remake/application_dependencies/app_dependencies.dart';
import 'package:http/http.dart' as http;

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
        backgroundColor: const Color(0xFF1E2A47),
        title: Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: const Center(
            child: Text(
              'Descargando himnario',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
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
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Text(
                      selectedSongbook.name,
                      style: const TextStyle(
                        color: Colors.white,
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
      audioURL: hymn.audioURL,
    ));
  });

  await sharedPreferencesManager.saveSelectedHymnbookId(selectedSongbook.id);
  await sharedPreferencesManager.saveHymnbookVersion(selectedSongbook.version); // Save hymnbook version
  Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext!, '/home', (route) => false);
  totalHymns.value = fetchedHymns.length;
  await sharedPreferencesManager.saveDownloadedSongbook(selectedSongbook.id);
  await sharedPreferencesManager.saveTotalHymns(totalHymns.value);
}

Future<void> downloadAudio(int hymnId, String audioURL, BuildContext context) async {
  BuildContext? downloadDialogContext;

  Navigator.pop(context);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      downloadDialogContext = context;  // Asignas el context a la variable
      return AlertDialog(
        backgroundColor: getDialogBGColors(context),
        title: Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Center(
            child: Text(
                'Descargando audio',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: getTextButtonColorssss(context),
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
                    color: getTextButtonColorssss(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );

  // Construye la URL completa
  final completeURL = 'https://himnariodev.bibliayopinion.com/uploads/audios/$hymnId/$audioURL';

  // Obtiene el directorio de documentos de la aplicación
  final directory = await getApplicationDocumentsDirectory();

  // Crea un archivo con la ruta donde se guardará el audio descargado
  final filePath = File('${directory.path}/$audioURL');

  // Realiza una solicitud HTTP GET al enlace del audio
  final response = await http.get(Uri.parse(completeURL));

  // Si la solicitud tiene éxito, guarda el contenido en el archivo
  if (response.statusCode == 200) {
    await filePath.writeAsBytes(response.bodyBytes);
  } else {
    throw Exception('Error al descargar el archivo');
  }

  if (downloadDialogContext != null) {
    Navigator.pop(downloadDialogContext!);
  }
}

Future<bool> isAudioFileDownloaded(String audioFileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = File('${directory.path}/$audioFileName');
  return filePath.existsSync();
}

Color getDialogBGColors(BuildContext context) {

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

Color getTextButtonColorssss(BuildContext context) {

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
