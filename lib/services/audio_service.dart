import 'package:audioplayers/audioplayers.dart';

class AudioService {

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio(String assetPath) async {
    await _audioPlayer.setSource(AssetSource(assetPath));
    await _audioPlayer.play(AssetSource(assetPath));
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}