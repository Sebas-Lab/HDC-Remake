import 'package:hdc_remake/app_dependencies.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class BuildSearchTextField extends StatefulWidget {
  const BuildSearchTextField({Key? key}) : super(key: key);

  @override
  State<BuildSearchTextField> createState() => _BuildSearchTextFieldState();
}

class _BuildSearchTextFieldState extends State<BuildSearchTextField> {

  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredHymns = [];

  @override
  void initState() {
    _searchController.addListener(_filterHymns);
  }

  Future<List<dynamic>> _loadHymnsFromJson() async {
    final jsonString = await rootBundle.loadString('assets/sample_hymns.json');
    final List<dynamic> hymns = jsonDecode(jsonString);
    return hymns;
  }

  // ----------------- FILTER BY ANY LETTER -----------------

  void _filterHymns() async  {
    String searchText = _searchController.text.toLowerCase();
    List<dynamic> hymns = await _loadHymnsFromJson();
    List<dynamic> filteredHymns = [];

    if (searchText.isNotEmpty) {
      for (var hymn in hymns) {
        if (hymn['title'].toLowerCase().contains(searchText)) {
          filteredHymns.add(hymn);
        }
      }
    }

    setState(() {
      _filteredHymns = filteredHymns;
    });
  }

  // ----------------- FILTER BY THE FIRST LETTER -----------------

  // void _filterHymns([String? text]) async {
  //   text = text ?? _searchController.text;
  //
  //   if (text.isEmpty) {
  //     setState(() {
  //       _filteredHymns = [];
  //     });
  //     return;
  //   }
  //
  //   String searchText = _searchController.text.toLowerCase();
  //   List<dynamic> hymns = await _loadHymnsFromJson();
  //
  //   if (searchText.isNotEmpty) {
  //     List<Map<String, dynamic>> filtered = [];
  //     for (Map<String, dynamic> hymn in hymns) {
  //       if (hymn['title'].toString().toLowerCase().startsWith(searchText.toLowerCase())) {
  //         filtered.add(hymn);
  //       }
  //     }
  //     setState(() {
  //       _filteredHymns = filtered;
  //     });
  //   } else {
  //     setState(() {
  //       _filteredHymns = hymns;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 50),
          child: const Text(
            'Buscar himnario',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF3DBAA6),
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  contentPadding: const EdgeInsets.only(left: 25, top: 20, bottom: 20, right: 20),
                  hintText: 'Ejemplo: Canta oh buen cristiano...',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _filteredHymns.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                _filteredHymns[index]['title'],
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                print('Tecla apretada');
              },
            );
          },
        ),
      ],
    );
  }
}