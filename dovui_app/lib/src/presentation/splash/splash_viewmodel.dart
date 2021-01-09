import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dovui_app/src/resource/model/question.dart';
import 'package:dovui_app/src/resource/services/sound_service.dart';
import 'package:dovui_app/src/utils/app_shared.dart';
import 'package:flutter/material.dart';
import '../../resource/resource.dart';
import '../base/base.dart';
import 'package:rxdart/rxdart.dart';

enum IsMusic { turnOff, turnOn }

class SplashViewModel extends BaseViewModel {
  final OtherRepository repository;
  final SoundService service;

  SplashViewModel({@required this.repository, @required this.service});

  final musicController = new BehaviorSubject<bool>();

  Sink<bool> get sinkMusic => musicController.sink;
  Stream<bool> get streamMusic => musicController.stream;


  List<Question> list;
  init() async {
   await playMusic();
   sinkMusic.add(await AppShared.getSound());
    if (await checkListQuestion()) {
      List<Question> listAnswer = await AppShared.getAnswer();
      if (list != null && list.length > 0) {
        NetworkState<List<Question>> data =
            await repository.getQuestionByIndex(listAnswer.length + 1 );
        await AppShared.setQuestions(data.data);
      } else {
        NetworkState<List<Question>> data =
            await repository.getQuestionByIndex(0);
        await AppShared.setQuestions(data.data);
      }
    } else {
      print("null");
    }
  }

  checkIMusic(IsMusic isMusick) async {
    switch (isMusick) {
      case IsMusic.turnOn:
        await AppShared.setSound(true);
        sinkMusic.add(true);
        service.playSound(GameSound.Music);
        break;
      case IsMusic.turnOff:
        await AppShared.setSound(false);
        sinkMusic.add(false);
        service.mute();
    }
  }

  playMusic() async {
    service.playSound(GameSound.Music);
    if (await AppShared.getSound()) {
      await service.unMute();
    } else {
      await service.mute();
    }

    await AppShared.getSound();
  }

  checkListQuestion() async {
    List<Question> lqs = await AppShared.getQuestions();
    if(lqs == null){ lqs.isEmpty;}
    return lqs.isEmpty;
  }

  void dispose() {
    musicController.close();
  }
}
