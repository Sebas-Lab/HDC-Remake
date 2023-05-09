import '../home_screen_dependencies.dart';
import 'dart:math'; // Asegúrate de agregar este import

typedef SongSelectedCallback = void Function(int index);

class SongList extends StatefulWidget {
  final SongSelectedCallback onSongSelected;
  final List<Hymn> hymns;
  final ValueNotifier<RangeValues> hymnRange;
  const SongList({Key? key, required this.onSongSelected, required this.hymns, required this.hymnRange}) : super(key: key);

  @override
  State<SongList> createState() => SongListState();
}

class SongListState extends State<SongList> {

  final selectedHymnbookIdNotifier = ValueNotifier<int?>(null);

  List<Hymn> hymns = [];
  List<Hymn> filteredHymns = [];
  SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager();

  @override
  void initState() {
    super.initState();
    loadHymns();
    selectedHymnbookIdNotifier.addListener(onSharedPreferencesChanged);
    // filteredHymns = widget.hymns;
  }

  @override
  void dispose() {
    selectedHymnbookIdNotifier.removeListener(onSharedPreferencesChanged);
    super.dispose();
    print('SongListState disposed'); // Agrega esta línea
    filteredHymns = widget.hymns;
  }

  void updateEnd() {
    int newEnd = widget.hymnRange.value.end.toInt();
    if (newEnd > hymns.length) {
      newEnd = hymns.length;
    }
    widget.hymnRange.value = RangeValues(widget.hymnRange.value.start, newEnd.toDouble());
  }

  void onSharedPreferencesChanged() async {
    // Comprueba si el himnario seleccionado ha cambiado
    int? newSelectedHymnbookId = await sharedPreferencesManager.getSelectedHymnbookId();
    int? currentHymnbookId = await sharedPreferencesManager.getSelectedHymnbookId(); // Obtiene el ID del himnario actualmente seleccionado
    if (newSelectedHymnbookId != null && newSelectedHymnbookId != currentHymnbookId) {
      // Si es así, actualiza la lista de himnos
      hymns = await sharedPreferencesManager.loadHymns(newSelectedHymnbookId);
      applyFilter(1, hymns.length); // Agrega esta línea para actualizar el rango de himnos
      setState(() {}); // Actualiza la pantalla con los nuevos himnos
    }
  }

  Future<void> loadHymns() async {
    int? selectedHymnbookId = await sharedPreferencesManager.getSelectedHymnbookId();
    if (selectedHymnbookId != null) {
      hymns = await sharedPreferencesManager.loadHymns(selectedHymnbookId);
      selectedHymnbookIdNotifier.value = selectedHymnbookId;
      setState(() {}); // Actualiza la pantalla con los nuevos himnos
      print('Loaded hymns for hymnbook $selectedHymnbookId');
    } else {
      // Manejar el caso en que no haya un himnario seleccionado
    }
  }

  void applyFilter(int start, int end) {
    filteredHymns = hymns.where((hymn) => hymn.id >= start && hymn.id <= end).toList();
    print('Applying filter: Start $start, End $end');
    if (start < 1) {
      start = 1;
    }
    if (end > hymns.length) {
      end = hymns.length;
    }
    if (start > end) {
      return; // No aplicar el filtro si el rango no es válido.
    }
    widget.hymnRange.value = RangeValues(start.toDouble(), end.toDouble());
  }

  void updateHymns(List<Hymn> newHymns) {
    setState(() {
      hymns = newHymns;
    });
  }

  void onSongSelected(int index) {
    Hymn selectedHymn = hymns[index - 1];
    Navigator.pushNamed(context, '/song', arguments: selectedHymn);
  }

  @override
  Widget build(BuildContext context) {
    return buildSongsList(context, widget.hymnRange, hymns, onSongSelected, filteredHymns); // Actualiza el parámetro hymnRange
  }
}

Widget buildSongsList(BuildContext context, ValueNotifier<RangeValues> hymnRange, List<Hymn> hymns, SongSelectedCallback onSongSelected, List<Hymn> filteredHymns) {

  return ValueListenableBuilder<RangeValues>(
      valueListenable: hymnRange,
      builder: (context, range, child) {
        int start = range.start.toInt() - 1;
        int end = range.end.toInt();
        return Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: hymnRange.value.end.toInt() - hymnRange.value.start.toInt() + 1,
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
    );
}