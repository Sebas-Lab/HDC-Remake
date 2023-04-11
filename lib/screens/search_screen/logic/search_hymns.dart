import 'package:hdc_remake/app_dependencies.dart';

Future<List<dynamic>> loadHymnsFromJson() async {
  final jsonString = await rootBundle.loadString('assets/sample_hymns.json');
  final List<dynamic> hymns = jsonDecode(jsonString);
  return hymns;
}

class SearchLogic {
  final TextEditingController searchController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;
  List<dynamic> filteredHymns = [];
  final VoidCallback? onFilteredHymnsChanged;

  SearchLogic({this.onFilteredHymnsChanged}) {
    searchController.addListener(_filterHymns);
  }

  void _filterHymns() async {

    String searchText = searchController.text.toLowerCase();
    final dbHelper = DatabaseHelper.instance;
    List<Hymn> hymns = await dbHelper.getAllHymns();
    List<dynamic> filteredHymnsResult = [];

    if (searchText.isNotEmpty) {
      for (var hymn in hymns) {

        if (hymn.name.toLowerCase().contains(searchText)) {
          filteredHymnsResult.add(hymn);
        }

        if (hymn.id.toString().toLowerCase().contains(searchText)) {
          filteredHymnsResult.add(hymn);
        }
      }
    }

    filteredHymns = filteredHymnsResult;
    onFilteredHymnsChanged?.call();
  }

  Future<List<Hymn>> loadHymnsFromDatabase() async {
    return dbHelper.getAllHymns();
  }
}