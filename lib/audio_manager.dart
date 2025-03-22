import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;

  final AudioPlayer _player = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer(); // separate from music player

  Future<void> playSfx(String file) async {
    final prefs = await SharedPreferences.getInstance();
    bool isSoundOn = prefs.getBool('soundOn') ?? true;
    double volume = prefs.getDouble('sfxVolume') ?? 1.0;

    if (!isSoundOn) return;

    await _sfxPlayer.play(
      AssetSource('audio/$file'),
      volume: volume,
    );
  }



  AudioManager._internal();

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    bool isMusicOn = prefs.getBool('musicOn') ?? true;
    if (isMusicOn) {
      await playMusic();
    }
  }

  Future<void> playMusic() async {
    final prefs = await SharedPreferences.getInstance();
    double volume = prefs.getDouble('musicVolume') ?? 0.5;
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setVolume(volume);
    await _player.play(AssetSource('audio/main_theme.mp3'));
  }

  Future<void> stopMusic() async {
    await _player.stop();
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

}
