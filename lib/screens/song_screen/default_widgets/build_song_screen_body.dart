import '../song_screen_dependencies.dart';

class BuildSongScreenBody extends StatefulWidget {
  const BuildSongScreenBody({Key? key}) : super(key: key);

  @override
  State<BuildSongScreenBody> createState() => _BuildSongScreenBodyState();
}

class _BuildSongScreenBodyState extends State<BuildSongScreenBody> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        BuildSong(),
      ],
    );
  }
}
