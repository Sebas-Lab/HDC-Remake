import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class ChangeSongBookScreen extends StatefulWidget {
  const ChangeSongBookScreen({Key? key}) : super(key: key);

  @override
  State<ChangeSongBookScreen> createState() => _ChangeSongBookScreenState();
}

class _ChangeSongBookScreenState extends State<ChangeSongBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const BuildChangeSongBookScreenAppbar(),
      body: const BuildChangeSongBookScreenBody(),
    );
  }
}
