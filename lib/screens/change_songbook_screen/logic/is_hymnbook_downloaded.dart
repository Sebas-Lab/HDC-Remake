import 'package:hdc_remake/application/application_dependencies.dart';

Future<bool> isHymnbookDownloaded(int hymnbookId) async {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  int hymnCount = await dbHelper.getHymnCountBySongbookId(hymnbookId);
  return hymnCount > 0;
}