import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class BuildChangeSongBookScreenBody extends StatefulWidget {
  const BuildChangeSongBookScreenBody({Key? key}) : super(key: key);

  @override
  State<BuildChangeSongBookScreenBody> createState() => BuildChangeSongBookScreenBodyState();
}

class BuildChangeSongBookScreenBodyState extends State<BuildChangeSongBookScreenBody> {
  Future<void> _onHymnbookChanged(int hymnbookId, int totalHymns) async {
    // Aquí es donde implementas el cambio de himnario y actualizas el estado
  }

  @override
  Widget build(BuildContext context) {
    return BuildSongBookItemList(onHymnbookChanged: _onHymnbookChanged);
  }
}