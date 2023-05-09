import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class SharedPreferencesManager {

  final String _selectedHymnbookIdKey = "selectedHymnbookIndex";
  static const String _downloadedSongbooksKey = "downloadedSongbooks";
  final ValueNotifier<int?> selectedHymnbookIdNotifier = ValueNotifier(null);
  static const String filterKey = 'selected_filter_range';
  static const String _totalHymnsKey = 'totalHymns';

  Future<void> saveSelectedHymnbookId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_selectedHymnbookIdKey, id);
  }

  Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    int? selectedHymnbookIndex = prefs.getInt(_selectedHymnbookIdKey);

    return selectedHymnbookIndex == null;
  }

  Future<int?> getSelectedHymnbookId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? selectedHymnbookId = prefs.getInt(_selectedHymnbookIdKey);
    return selectedHymnbookId;
  }

  Future<String> getHymnbookVersion(int id, List<Songbook> songbooks) async {
    Songbook selectedSongbook = songbooks.firstWhere(
          (songbook) => songbook.id == id,
      orElse: () => Songbook(id: -1, name: '', songAmount: 0, img: '', version: ''),
    );

    if (selectedSongbook.id == -1) {
      throw Exception('No se encontró ningún himnario con el id $id');
    }

    return selectedSongbook.version;
  }

  Future<void> saveHymnbookVersion(String version) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('hymnbook_version', version);
  }

  Future<String?> getHymnbookVersionFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('hymnbook_version');
  }

  Future<void> saveDownloadedSongbook(int songbookId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> downloadedSongbooks = prefs.getStringList(_downloadedSongbooksKey) ?? [];
    downloadedSongbooks.add(songbookId.toString());
    await prefs.setStringList(_downloadedSongbooksKey, downloadedSongbooks);
    await saveSelectedHymnbookId(songbookId);
    selectedHymnbookIdNotifier.value = songbookId;
  }

  Future<List<int>> getDownloadedSongbooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> downloadedSongbooks = prefs.getStringList(_downloadedSongbooksKey) ?? [];
    return downloadedSongbooks.map((idString) => int.parse(idString)).toList();
  }

  Future<List<Hymn>> loadHymns(int songbookId) async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    List<Hymn> hymns = await dbHelper.loadHymns(songbookId);
    return hymns;
  }

  Future<void> saveSelectedFilterIndex(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(filterKey, index);
  }

  Future<int?> getSelectedFilterIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(filterKey);
  }

  Future<void> saveTotalHymns(int totalHymns) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_totalHymnsKey, totalHymns);
  }

  Future<int?> loadTotalHymns() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_totalHymnsKey);
  }
}
