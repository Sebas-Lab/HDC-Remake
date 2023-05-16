import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

Future<bool> isHymnbookDownloaded(int hymnbookId) async {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  int hymnCount = await dbHelper.getHymnCountBySongbookId(hymnbookId);
  return hymnCount > 0;
}