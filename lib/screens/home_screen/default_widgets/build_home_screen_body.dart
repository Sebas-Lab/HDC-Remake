import '../../../global_data/total_hymns.dart';
import '../home_screen_dependencies.dart';

class BuildHomeScreenBody extends StatefulWidget {
  const BuildHomeScreenBody({Key? key}) : super(key: key);

  @override
  State<BuildHomeScreenBody> createState() => _BuildHomeScreenBodyState();
}

class _BuildHomeScreenBodyState extends State<BuildHomeScreenBody> {
  final songListKey = GlobalKey<SongListState>();

  void _onSongSelected(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('Build called, hymnsNotifier value count: ${hymnsNotifier.value.length}');
    return ValueListenableBuilder<List<Hymn>>(
      valueListenable: hymnsNotifier,
      builder: (context, hymns, child) {
        if (hymns.isNotEmpty) {
          print('hymns is not empty, count: ${hymns.length}');
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
              SongList(key: songListKey, onSongSelected: _onSongSelected, hymns: hymns),
            ],
          );
        } else {
          return const Center(child: Text('No se cargaron los himnos', style: TextStyle(color: Colors.white)));
        }
      },
    );
  }
}
