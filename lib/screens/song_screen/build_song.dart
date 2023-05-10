import 'package:hdc_remake/application_dependencies/app_dependencies.dart';
import 'package:path_provider/path_provider.dart';

import '../../application_themes.dart';

class BuildSong extends StatefulWidget {
  final Hymn hymn;
  const BuildSong({Key? key, required this.hymn}) : super(key: key);

  @override
  BuildSongState createState() => BuildSongState();
}

class BuildSongState extends State<BuildSong> {

  final AudioService audioService = AudioService();
  bool isPlaying = false;

  void toggleAudioPlayback() async {
    if (isPlaying) {
      await audioService.stopAudio();
      setState(() {
        isPlaying = false;
      });
    } else {
      if (widget.hymn.audioURL != null && widget.hymn.audioURL!.isNotEmpty) {
        String audioFileName = widget.hymn.audioURL!;
        bool isDownloaded = await isAudioFileDownloaded(audioFileName);
        if (!isDownloaded) {
          await downloadAudio(widget.hymn.id, audioFileName, context);
        } else {
          // Reproducir el audio descargado
          final directory = await getApplicationDocumentsDirectory();
          final filePath = '${directory.path}/$audioFileName';
          await audioService.playAudio(filePath);
          setState(() {
            isPlaying = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Número: ${widget.hymn.id}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor == AppTheme().darkTheme.primaryColor ? Colors.white : const Color(0xFF3A3A3A),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 4),
            child: IconButton(
              onPressed: fontSizeProvider.increaseFontSize,
              icon: Icon(
                Icons.add_circle,
                size: 35,
                color: getIconsColors(context),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 4),
            child: IconButton(
              onPressed: fontSizeProvider.decreaseFontSize,
              icon: Icon(
                Icons.remove_circle,
                size: 35,
                color: getIconsColors(context),
              ),
            ),
          ),
          if (widget.hymn.audioURL != null && widget.hymn.audioURL!.isNotEmpty)
          Container(
            child: isPlaying == true
                ? Container(
              margin: const EdgeInsets.only(right: 4),
              child: IconButton(
                onPressed: toggleAudioPlayback,
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
                onPressed: () async {
                  if (widget.hymn.audioURL != null && widget.hymn.audioURL!.isNotEmpty) {
                    String audioFileName = widget.hymn.audioURL!;
                    bool isDownloaded = await isAudioFileDownloaded(audioFileName);
                    if (!isDownloaded) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: getDialogBGColor(context),
                              title: Text(
                                'Audio',
                                style: TextStyle(
                                  color: getTextButtonColorsss(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                '¿Quieres descargar el audio de este himno?',
                                style: TextStyle(
                                  color: getTextButtonColorsss(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cerrar',
                                    style: TextStyle(
                                      color: getTextButtonColorsss(context),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: TextButton(
                                    onPressed: () async {
                                      await downloadAudio(widget.hymn.id, audioFileName, context);
                                    },
                                    child: Text(
                                      'Descargar',
                                      style: TextStyle(
                                        color: getTextButtonColorsss(context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                      );
                    } else {
                      // Si ya está descargado, reproduzca el audio directamente
                      final directory = await getApplicationDocumentsDirectory();
                      final filePath = '${directory.path}/$audioFileName';
                      await audioService.playAudio(filePath, callback: () {
                        setState(() {
                          isPlaying = false;
                        });
                      });
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  }
                },
                icon: Icon(
                  Icons.play_circle,
                  size: 35,
                  color: getIconsColors(context),
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
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: getTextButtonColorsss(context),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 0),
                    child: Divider(
                      color: getDividerColorss(context),
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
                        color: getTextButtonColorsss(context),
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

Color getDialogBGColor(BuildContext context) {

  var themeData = Theme.of(context);

  if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
    return const Color(0xFF1E2A47);
  } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
    return const Color(0xFFC5CAE9);
  } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
    return const Color(0xFF3C3C3C);
  }

  return Colors.white;
}

Color getTextButtonColorsss(BuildContext context) {

  var themeData = Theme.of(context);

  if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
    return Colors.white;
  } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
    return const Color(0xFF3A3A3A);
  } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
    return Colors.white;
  }

  return Colors.white;
}

Color getDividerColorss(BuildContext context) {

  var themeData = Theme.of(context);

  if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
    return const Color(0xFF3DBAA6);
  } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
    return const Color(0xFF009BFF);
  } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
    return Colors.white;
  }

  return Colors.white;
}

Color getIconsColors(BuildContext context) {

  var themeData = Theme.of(context);

  if (themeData.primaryColor == AppTheme().oceanTheme.primaryColor) {
    return const Color(0xFF1E2A47);
  } else if (themeData.primaryColor == AppTheme().lightTheme.primaryColor) {
    return const Color(0xFF009BFF);
  } else if (themeData.primaryColor == AppTheme().darkTheme.primaryColor) {
    return Colors.white;
  }

  return Colors.white;
}
