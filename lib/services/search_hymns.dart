import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class SearchLogic {

  final TextEditingController searchController = TextEditingController();
  List<dynamic> filteredHymns = [];
  final VoidCallback onFilteredHymnsChanged;

  SearchLogic({required this.onFilteredHymnsChanged}) {
    searchController.addListener(_filterHymns);
  }

  Future<List<dynamic>> loadHymnsFromJson() async {
    final jsonString = await rootBundle.loadString('assets/sample_hymns.json');
    final List<dynamic> hymns = jsonDecode(jsonString);
    return hymns;
  }

  void _filterHymns() async {
    String searchText = searchController.text.toLowerCase();
    List<dynamic> hymns = await loadHymnsFromJson();
    List<dynamic> filteredHymnsResult = [];

    if (searchText.isNotEmpty) {
      for (var hymn in hymns) {
        if (hymn['title'].toLowerCase().contains(searchText)) {
          filteredHymnsResult.add(hymn);
        }
      }
    }

    filteredHymns = filteredHymnsResult;
    onFilteredHymnsChanged();
  }
}
