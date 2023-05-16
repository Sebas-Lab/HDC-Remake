import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

Stream<List<SongBooks>> fetchSongbooksAndUpdateDownloadStatus() async* {
  List<SongBooks> songbooks = await fetchSongBooks();
  await updateSongbooksDownloadStatus(songbooks);
  yield songbooks;
}