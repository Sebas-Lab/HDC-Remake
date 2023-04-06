import 'package:hdc_remake/app_dependencies.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({Key? key}) : super(key: key);

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FontSizeProvider(),
      child: const Scaffold(
        backgroundColor: Color(0xFF1E2A47),
        appBar: BuildSongScreenAppbar(),
        body: BuildSongScreenBody(),
      ),
    );
  }
}
