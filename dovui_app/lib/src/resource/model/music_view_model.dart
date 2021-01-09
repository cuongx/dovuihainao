import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dovui_app/src/presentation/base/base.dart';
import 'package:dovui_app/src/resource/repo/other_repository.dart';
import 'package:flutter/material.dart';

class MusicViewModel extends BaseViewModel {
  final OtherRepository repository;
  final audio = [
    Audio(
      "assets/sound/music_bg.mp3",
    ),
    Audio("assets/sound/play.wav"),
    Audio(
      "assets/sound/victory.wav",
    ),
    Audio("assets/sound/fail.wav"),
    Audio("assets/sound/moreapp.wav"),
    Audio("assets/sound/back.wav"),
  ];
  final AssetsAudioPlayer assetsAudioScreen = AssetsAudioPlayer();
  final AssetsAudioPlayer assetsAudioPlay = AssetsAudioPlayer();
  final AssetsAudioPlayer assetsAudioVictory = AssetsAudioPlayer();
  final AssetsAudioPlayer assetsAudioFail = AssetsAudioPlayer();
  final AssetsAudioPlayer assetsBack = AssetsAudioPlayer();
  final AssetsAudioPlayer assetsMoreApp = AssetsAudioPlayer();

  MusicViewModel({@required this.repository});

  void musicListen(bool select) {
      if (select) {
      assetsAudioPlay.play();
    }
    assetsAudioPlay.pause();
  }

  init() async {
    assetsAudioScreen.open(
      audio[0],
      showNotification: true,
      autoStart: false,
      volume: 0.25,
      seek: Duration(seconds: 150),
      forceOpen: true,
    );

    assetsAudioPlay.open(
      audio[1],
      showNotification: true,
      autoStart: false,
      volume: 0.8,
      seek: Duration(seconds: 150),
      forceOpen: false,
    );
    // assetsAudioPlay.open(
    //   audio[3],
    //   showNotification: true,
    //   autoStart: false,
    //   volume: 0.8,
    //   seek: Duration(seconds: 150),
    //   forceOpen: false,
    // );
    assetsMoreApp.open(
      audio[4],
      showNotification: true,
      autoStart: false,
      volume: 0.8,
      seek: Duration(seconds: 150),
      forceOpen: false,
    );
    assetsBack.open(
      audio[5],
      showNotification: true,
      autoStart: false,
      volume: 0.8,
      seek: Duration(seconds: 150),
      forceOpen: false,
    );
  }
}
