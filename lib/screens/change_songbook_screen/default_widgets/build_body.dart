import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class BuildChangeSongBookScreenBody extends StatefulWidget {
  const BuildChangeSongBookScreenBody({Key? key}) : super(key: key);

  @override
  State<BuildChangeSongBookScreenBody> createState() => BuildChangeSongBookScreenBodyState();
}

class BuildChangeSongBookScreenBodyState extends State<BuildChangeSongBookScreenBody> {

  @override
  Widget build(BuildContext context) {
    return const BuildSongBookItemList();
  }
}