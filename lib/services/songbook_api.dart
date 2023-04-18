import 'package:hdc_remake/app_dependencies.dart';
import 'package:hdc_remake/screens/select_hymn/logic/popup.dart';
import 'package:http/http.dart' as http;
import '../models/songbook.dart';

ValueNotifier<List<Hymn>> hymnsNotifier = ValueNotifier([]);

Future<List<Songbook>> fetchSongs() async {

  final response = await http.get(Uri.parse('http://himnariodev.bibliayopinion.com/api/getSongsbooks'));
  final jsonResponse = jsonDecode(response.body);

  if (jsonResponse['success'] == true) {

    final jsonResponse = jsonDecode(response.body);
    final List<dynamic> data = jsonResponse['data'];
    final List<Songbook> songbooks = data.map((json) => Songbook.fromJson(json)).toList();
    return songbooks;

  } else {
    print('Error al conectar con el servidor. Código de estado: ${response.statusCode}');
    return [];
  }
}

Future<List<Hymn>> fetchSongbookData(int songbookId) async {
  print('Iniciando la descarga del himnario con ID: $songbookId');
  final response = await http.get(Uri.parse('http://himnariodev.bibliayopinion.com/api/getSongsBySongsbooks/$songbookId'));
  final jsonResponse = jsonDecode(response.body);

  if (jsonResponse['success'] == true) {
    print('Descarga del himnario exitosa');
    final List<dynamic> data = jsonResponse['data'];
    final List<Hymn> hymns = data.map((json) => Hymn.fromMap(json)).toList();

    // Agrega esta línea para verificar si se extraen correctamente los nombres de los himnos
    hymns.forEach((hymn) => print('Hymn: ${hymn.name}'));

    return hymns;
  } else {
    print('Error al conectar con el servidor. Código de estado: ${response.statusCode}');
    return [];
  }
}

Future<void> downloadSongbook(Songbook songbook, PopupLogic popupLogic, BuildContext context) async {
  popupLogic.showDownloadingDialog(context, "Descargando ${songbook.name}", true);
  List<Hymn> fetchedHymns = await fetchSongbookData(songbook.id);
  hymnsNotifier.value = fetchedHymns;
  Navigator.of(context).pop();
}