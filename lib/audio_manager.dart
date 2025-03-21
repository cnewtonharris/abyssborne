import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;

  final AudioPlayer _player = AudioPlayer();

  AudioManager._internal();

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    bool isMusicOn = prefs.getBool('musicOn') ?? true;
    if (isMusicOn) {
      await playMusic();
    }
  }

  Future<void> playMusic() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource('audio/main_theme.mp3'));
  }

  Future<void> stopMusic() async {
    await _player.stop();
  }
}
