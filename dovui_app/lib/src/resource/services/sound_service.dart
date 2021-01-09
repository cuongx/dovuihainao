import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dovui_app/src/utils/app_shared.dart';
import 'package:flutter/material.dart';

enum GameSound {
  Wrong,
  Right,
  Loss,
  Music,
  MoreApp,
  Play,
  Back,
}

class SoundService extends WidgetsBindingObserver {
  static AudioPlayer _fixerAudio;
  static AudioCache _player;
  static AudioPlayer _bgFixer;
  static AudioCache _bgPlayer;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _bgFixer.pause(); // Audio player is a custom class with resume and pause static methods
    } else {
      _bgFixer.pause();
    }
  }

  init() async {
    _fixerAudio = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    _player = AudioCache(fixedPlayer: _fixerAudio);

    _bgFixer = AudioPlayer(
        mode: PlayerMode.MEDIA_PLAYER, playerId: 'background_music');
    _bgPlayer = AudioCache(fixedPlayer: _bgFixer);
    _bgFixer.setReleaseMode(ReleaseMode.LOOP);
    // unMute();
    // await playSound(GameSound.Music);
  }

  Future<void> playSound(GameSound name) async {
    if (await AppShared.getSound()) {
      switch (name) {
        case GameSound.Right:
          await _player.play('sound/victory.wav');
          break;
        case GameSound.Wrong:
          await _player.play('sound/fail.wav');
          break;
        case GameSound.Loss:
          await _player.play('sound/fail.wav');
          break;
        case GameSound.MoreApp:
          await _player.play('sound/moreapp.wav');
          break;
        case GameSound.Music:
          _bgFixer.stop();
          await _bgPlayer.loop('sound/music_bg.mp3');
          break;
        case GameSound.Back:
          await _player.play('sound/back.wav');
          break;
        case GameSound.Play:
          await _player.play('sound/play.wav');
      }
    }else{
      print("nhạc đã tắt ");
    }
  }

  Future<void> mute() async {
    await _fixerAudio.pause();
    await _bgFixer.pause();
  }

  Future<void> unMute() async {
    await _fixerAudio.setVolume(0.8);
    await _bgFixer.setVolume(0.2);
  }

}