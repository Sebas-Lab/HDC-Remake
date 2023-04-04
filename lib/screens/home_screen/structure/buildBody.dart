import './home_screen_dependencies.dart';

Widget buildBody(BuildContext context) {

  return Container(
    child: Column(
      children: [
        buildTopSide(context),
        buildSearchByNumberText(),
        buildSearchByNumber(),
        buildSongsList(context),
      ],
    ),
  );
}
