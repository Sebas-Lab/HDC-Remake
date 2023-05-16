import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

void onHymnbookChanged(int hymnbookId, int totalHymns, Function callback) async {

  SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager();
  final GlobalKey<SongListState> songListKey = GlobalKey();

  await sharedPreferencesManager.saveSelectedHymnbookId(hymnbookId);
  await sharedPreferencesManager.saveTotalHymns(totalHymns);
  List<Hymn> hymns = await DatabaseHelper.instance.getHymnsBySongbookId(hymnbookId);
  hymnsNotifier.value = List<Hymn>.from(hymns);
  songListKey.currentState?.applyFilter(1, hymns.length);
  callback();
}