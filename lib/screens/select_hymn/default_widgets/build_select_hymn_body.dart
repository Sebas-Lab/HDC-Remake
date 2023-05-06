import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class BuildSelectHymnBody extends StatefulWidget {
  const BuildSelectHymnBody({Key? key}) : super(key: key);

  @override
  State<BuildSelectHymnBody> createState() => _BuildSelectHymnBodyState();
}

class _BuildSelectHymnBodyState extends State<BuildSelectHymnBody> {
  PopupLogic popupLogic = PopupLogic();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Songbook>>(

      future: fetchSongs(),
      builder: (BuildContext context, AsyncSnapshot<List<Songbook>> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data == null) {
          return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white),));
        } else {

          List<Songbook> songbooks = snapshot.data!;

          return Scaffold(
            backgroundColor: const Color(0xFF1E2A47),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
                  child: const Text(
                    'Selecciona un himnario',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 50),
                  child: const Divider(
                    color: Colors.white,
                    thickness: 1.0,
                    indent: 110.0,
                    endIndent: 110.0,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: songbooks.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: Container(
                            padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                            margin: const EdgeInsets.only(bottom: 20.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xFF3DBAA6),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager();
                                sharedPreferencesManager.saveSelectedHymnbookId(songbooks[index].id);
                                downloadHymns(songbooks[index].id, scaffoldKey, songbooks);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      songbooks[index].name,
                                      style: const TextStyle(
                                        color: Color(0xFF3A3A3A),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15.0),
                                  const Icon(Icons.download, color: Color(0xFF3A3A3A)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}