import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class BuildSong extends StatefulWidget {
  final Hymn hymn;
  const BuildSong({Key? key, required this.hymn}) : super(key: key);

  @override
  BuildSongState createState() => BuildSongState();
}

class BuildSongState extends State<BuildSong> {

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
          'Número: ${widget.hymn.id}',
          style: const TextStyle(
            fontSize: 20,
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
          if (widget.hymn.audioURL != null && widget.hymn.audioURL!.isNotEmpty)
          Container(
            child: isPlaying == true
                ? Container(
              margin: const EdgeInsets.only(right: 4),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    // isPlaying = false;
                  });
                  // audioService.stopAudio();
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
                    // isPlaying = true;
                  });
                  // audioService.playAudio('audio/audioSample.mp3');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color(0xFF1E2A47),
                        title: const Text(
                          'Audio',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: const Text(
                          '¿Quieres descargar el audio de este himno?',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cerrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: TextButton(
                              onPressed: () {
                                downloadAudio(widget.hymn.id, widget.hymn.audioURL!);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Descargar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  );
                },
                icon: const Icon(
                  Icons.play_circle,
                  size: 35,
                  color: Color(0xFF1E2A47),
                ),
              ),
            ),
          ),
          WillPopScope(
            child: Container(),
            onWillPop: () {
              Navigator.pop(context);
              audioService.stopAudio();
              return Future.value(false);
            }
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      widget.hymn.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 0),
                    child: const Divider(
                      color: Color(0xFF3DBAA6),
                      thickness: 2.0,
                      indent: 20.0,
                      endIndent: 20.0,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25, bottom: 25),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
