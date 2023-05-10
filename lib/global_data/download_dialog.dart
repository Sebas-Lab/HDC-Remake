import 'package:hdc_remake/screens/settings_screen/settings_screen_dependencies.dart';

import '../models/songbooks.dart';

class DownloadDialog extends StatefulWidget {
  final SongBooks songbook;
  final Function(SongBooks) onDownloadComplete;
  final Future<void> Function(SongBooks) downloadHymnsForSongbook;  // Añade esta línea

  const DownloadDialog({
    Key? key,
    required this.songbook,
    required this.onDownloadComplete,
    required this.downloadHymnsForSongbook,  // Añade esta línea
  }) : super(key: key);

  @override
  _DownloadDialogState createState() => _DownloadDialogState();
}

class _DownloadDialogState extends State<DownloadDialog> {
  bool isDownloading = false;

  Future<void> startDownload() async {
    setState(() {
      isDownloading = true;
    });

    await widget.downloadHymnsForSongbook(widget.songbook);  // Usa widget.downloadHymnsForSongbook

    setState(() {
      isDownloading = false;
    });

    widget.onDownloadComplete(widget.songbook);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Descargar Himnario',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: isDownloading ? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Text(
                    widget.songbook.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ) : Text(
        '¿Quieres descargar el himnario ${widget.songbook.name}?',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFF1E2A47),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'No',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: isDownloading ? null : startDownload,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Text(
              'Descargar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}