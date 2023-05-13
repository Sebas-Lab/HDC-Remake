import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class SearchLogic {
  final TextEditingController searchController = TextEditingController();
  List<dynamic> filteredHymns = [];
  final VoidCallback? onFilteredHymnsChanged;

  SearchLogic({this.onFilteredHymnsChanged}) {
    searchController.addListener(_filterHymns);
  }

  void _filterHymns() {
    String searchText = removeDiacritics(searchController.text.toLowerCase());
    List<Hymn> hymns = hymnsNotifier.value;
    Set<Hymn> resultSet = {};

    if (searchText.isNotEmpty) {
      for (var hymn in hymns) {
        if (removeDiacritics(hymn.name.toLowerCase()).contains(searchText) ||
            removeDiacritics(hymn.lyrics.toLowerCase()).contains(searchText) ||
            hymn.id.toString().toLowerCase().contains(searchText)) {
          resultSet.add(hymn);
        }
      }
    }

    filteredHymns = resultSet.toList();
    onFilteredHymnsChanged?.call();
  }
}