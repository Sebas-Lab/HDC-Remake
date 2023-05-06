import '../home_screen_dependencies.dart';

typedef SongSelectedCallback = void Function(int index);

class SongList extends StatefulWidget {
  final SongSelectedCallback onSongSelected;
  final List<Hymn> hymns;
  const SongList({Key? key, required this.onSongSelected, required this.hymns}) : super(key: key);

  @override
  State<SongList> createState() => SongListState();
}

class SongListState extends State<SongList> {

  int start = 0;
  int end = 50;
  List<Hymn> hymns = [];
  SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager();

  @override
  void initState() {
    super.initState();
    loadHymns();
    sharedPreferencesManager.selectedHymnbookIdNotifier.addListener(onSharedPreferencesChanged);
  }

  @override
  void dispose() {
    sharedPreferencesManager.selectedHymnbookIdNotifier.removeListener(onSharedPreferencesChanged);
    super.dispose();
  }

  void onSharedPreferencesChanged() async {
    // Comprueba si el himnario seleccionado ha cambiado
    int? newSelectedHymnbookId = await sharedPreferencesManager.getSelectedHymnbookId();
    int? currentHymnbookId = await sharedPreferencesManager.getSelectedHymnbookId(); // Obtiene el ID del himnario actualmente seleccionado
    if (newSelectedHymnbookId != null && newSelectedHymnbookId != currentHymnbookId) {
      // Si es así, actualiza la lista de himnos
      hymns = await sharedPreferencesManager.loadHymns(newSelectedHymnbookId);
      setState(() {}); // Actualiza la pantalla con los nuevos himnos
    }
  }

  Future<void> loadHymns() async {
    int? selectedHymnbookId = await sharedPreferencesManager.getSelectedHymnbookId();
    if (selectedHymnbookId != null) {
      hymns = await sharedPreferencesManager.loadHymns(selectedHymnbookId);
      setState(() {}); // Actualiza la pantalla con los nuevos himnos
    } else {
      // Manejar el caso en que no haya un himnario seleccionado
    }
  }

  void applyFilter(int newStart, int newEnd) {
    setState(() {
      start = newStart - 1;
      end = newEnd;
    });
  }

  void onSongSelected(int index) {
    Hymn selectedHymn = hymns[index - 1];
    Navigator.pushNamed(context, '/song', arguments: selectedHymn);
  }

  @override
  Widget build(BuildContext context) {
    return buildSongsList(context, start, end, hymns, onSongSelected);
  }
}

Widget buildSongsList(BuildContext context, int start, int end, List<Hymn> hymns, SongSelectedCallback onSongSelected) {
  return Expanded(
    child: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: end - start,
            itemBuilder: (BuildContext context, int index) {

              Hymn? hymn = (index + start) < hymns.length ? hymns[index + start] : null;

              if (hymn == null) {
                return SizedBox.shrink();
              }

              return Container(
                padding: const EdgeInsets.only(left: 20, top: 7, bottom: 7, right: 20),
                margin: const EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF1E2A47),
                    padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                    shadowColor: Colors.black,
                    elevation: 15,
                  ),
                  onPressed: () {
                    onSongSelected(index + start + 1);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${index + start + 1} - ${hymn.name}',
                      style: const TextStyle(
                        height: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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