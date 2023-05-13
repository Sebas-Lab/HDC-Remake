import 'package:hdc_remake/application_dependencies/app_dependencies.dart';

class AudioService {

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio(String audioFileName, {Function? callback}) async {
    await _audioPlayer.play(DeviceFileSource(audioFileName));
    _audioPlayer.onPlayerComplete.listen((event) {
      callback?.call();
    });
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}