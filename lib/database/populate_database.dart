import 'package:hdc_remake/app_dependencies.dart';

String nullAwareToString(dynamic value) {
  return value == null ? '' : value.toString();
}

void populateDatabase() async {
  final dbHelper = DatabaseHelper.instance;
  final allHymns = await dbHelper.getAllHymns();

  if (allHymns.isEmpty) {
    List<dynamic> hymns = await loadHymnsFromJson();

    for (var hymnData in hymns) {
      Hymn hymn = Hymn(
        id: hymnData['id'],
        name: nullAwareToString(hymnData['title']),
        lyrics: nullAwareToString(hymnData['lyrics']),
      );
      int insertedId = await dbHelper.insert(hymn);
      print("Himno insertado: ${hymn.name}, ID: $insertedId");
    }
  } else {
    print("La base de datos ya contiene ${allHymns.length} himnos.");
  }
}