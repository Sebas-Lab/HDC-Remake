import '../home_screen_dependencies.dart';

class BuildHomeScreenBody extends StatefulWidget {
  const BuildHomeScreenBody({Key? key}) : super(key: key);

  @override
  State<BuildHomeScreenBody> createState() => _BuildHomeScreenBodyState();
}

class _BuildHomeScreenBodyState extends State<BuildHomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSearchByNumber(context),
        buildSongsList(context),
      ],
    );
  }
}
