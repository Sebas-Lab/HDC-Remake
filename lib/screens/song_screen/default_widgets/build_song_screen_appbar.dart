import 'package:hdc_remake/app_dependencies.dart';

class BuildSongScreenAppbar extends StatefulWidget with PreferredSizeWidget {
  const BuildSongScreenAppbar({Key? key}) : super(key: key);

  @override
  State<BuildSongScreenAppbar> createState() => _BuildSongScreenAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BuildSongScreenAppbarState extends State<BuildSongScreenAppbar> {

  final AudioService _audioService = AudioService();
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: const Color(0xFF3DBAA6),
      title: const Text(
        'Iglesia de Cristo.',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3A3A3A),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 4),
          child: IconButton(
            onPressed: fontSizeProvider.increaseFontSize,
            icon: const Icon(
              Icons.add_circle,
              size: 35,
              color: Color(0xFF1E2A47),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 4),
          child: IconButton(
            onPressed: fontSizeProvider.decreaseFontSize,
            icon: const Icon(
              Icons.remove_circle,
              size: 35,
              color: Color(0xFF1E2A47),
            ),
          ),
        ),
        Container(
          child: _isPlaying == true
              ? Container(
            margin: const EdgeInsets.only(right: 4),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isPlaying = false;
                });
                _audioService.stopAudio();
              },
              icon: const Icon(
                Icons.stop_circle,
                size: 35,
                color: Color(0xFF1E2A47),
              ),
            ),
          )
              : Container(
            margin: const EdgeInsets.only(right: 4),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isPlaying = true;
                });
                _audioService.playAudio('audio/audioSample.mp3');
              },
              icon: const Icon(
                Icons.play_circle,
                size: 35,
                color: Color(0xFF1E2A47),
              ),
            ),
          ),
        ),
      ],
    );
  }
}