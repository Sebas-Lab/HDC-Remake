import 'package:hdc_remake/app_dependencies.dart';

class BuildSong extends StatefulWidget {
  final Hymn hymn;

  const BuildSong({Key? key, required this.hymn}) : super(key: key);

  @override
  _BuildSongState createState() => _BuildSongState();
}

class _BuildSongState extends State<BuildSong> {

  final AudioService audioService = AudioService();
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1E2A47),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFF3DBAA6),
        title: Text(
          widget.hymn.name,
          style: const TextStyle(
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
            child: isPlaying == true
                ? Container(
              margin: const EdgeInsets.only(right: 4),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isPlaying = false;
                  });
                  audioService.stopAudio();
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
                    isPlaying = true;
                  });
                  audioService.playAudio('audio/audioSample.mp3');
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
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 50, bottom: 30, left: 30, right: 30),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                widget.hymn.lyrics,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizeProvider.fontSize,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
