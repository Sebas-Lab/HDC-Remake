import 'package:hdc_remake/application/application_dependencies.dart';

class BuildHomeScreenBody extends StatefulWidget {
  const BuildHomeScreenBody({Key? key}) : super(key: key);

  @override
  State<BuildHomeScreenBody> createState() => _BuildHomeScreenBodyState();
}

class _BuildHomeScreenBodyState extends State<BuildHomeScreenBody> {
  final GlobalKey<SongListState> songListKey = GlobalKey();
  final ValueNotifier<RangeValues> hymnRange = ValueNotifier(const RangeValues(1, 50)); // Agrega esta línea

  void _onSongSelected(int index) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadFiltersRange();
  }

  void loadFiltersRange() async{
    SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager();
    int? loadedTotalHymns = await sharedPreferencesManager.loadTotalHymns();
    if (loadedTotalHymns != null) {
      totalHymns.value = loadedTotalHymns;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Hymn>>(
      valueListenable: hymnsNotifier,
      builder: (context, hymns, child) {
        if (hymns.isNotEmpty) {
          return Column(
            children: [
              BuildSearchByNumber(
                onFilter: (int start, int end) {
                  if (end > hymns.length) {
                    end = hymns.length;
                  }
                  songListKey.currentState?.applyFilter(start, end);
                },
                totalHymns: totalHymns,
              ),
              SongList(
                key: songListKey,
                onSongSelected: _onSongSelected,
                hymns: hymns,
                hymnRange: hymnRange, // Añade esta línea
              ),
            ],
          );
        } else {
          return const Center(child: Text('No se cargaron los himnos', style: TextStyle(color: Colors.white)));
        }
      },
    );
  }
}
