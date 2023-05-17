import 'package:hdc_remake/application/application_dependencies.dart';


Future<void> updateSongbooksDownloadStatus(List<SongBooks> songbooksToUpdate) async {
  for (int i = 0; i < songbooksToUpdate.length; i++) {
    bool isDownloaded = await isHymnbookDownloaded(songbooksToUpdate[i].id);
    songbooksToUpdate[i].isDownloaded = isDownloaded;
  }
}