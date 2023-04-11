import 'package:hdc_remake/app_dependencies.dart';

class BuildSearchTextField extends StatefulWidget {
  const BuildSearchTextField({Key? key}) : super(key: key);

  @override
  State<BuildSearchTextField> createState() => _BuildSearchTextFieldState();
}

class _BuildSearchTextFieldState extends State<BuildSearchTextField> {

  late SearchLogic searchLogic;

  @override
  void initState() {
    searchLogic = SearchLogic(onFilteredHymnsChanged: _onFilteredHymnsChanged);
    searchLogic.loadHymnsFromJson();
    super.initState();
  }

  void _onFilteredHymnsChanged() {
    setState(() {});
  }

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
                controller: searchLogic.searchController,
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
          itemCount: searchLogic.filteredHymns.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                searchLogic.filteredHymns[index]['title'],
                style: const TextStyle(color: Colors.white),
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