import '../home_screen_dependencies.dart';

class BuildHomeScreenBody extends StatefulWidget {
  const BuildHomeScreenBody({Key? key}) : super(key: key);

  @override
  State<BuildHomeScreenBody> createState() => _BuildHomeScreenBodyState();
}

class _BuildHomeScreenBodyState extends State<BuildHomeScreenBody> {

  final songListKey = GlobalKey<SongListState>();

  void _onSongSelected(int index) {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSearchByNumber(context, (int start, int end) => {
          if(end > 368) end = 368,
          songListKey.currentState?.applyFilter(start, end),
        }),
        SongList(key: songListKey, onSongSelected: _onSongSelected),
      ],
    );
  }
}
