import 'dart:async';
import 'dart:math';
import 'package:dovui_app/src/presentation/base/base_viewmodel.dart';
import 'package:dovui_app/src/resource/model/question.dart';
import 'package:dovui_app/src/resource/resource.dart';
import 'package:dovui_app/src/resource/services/sound_service.dart';
import 'package:dovui_app/src/resource/services/wifi_service.dart';
import 'package:dovui_app/src/utils/app_shared.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class HomePageViewModel extends BaseViewModel {
  final OtherRepository repository;
  final SoundService service;
  HomePageViewModel({@required this.repository, this.service});

  final questionController = new BehaviorSubject<List<Question>>();
  final questController = new BehaviorSubject<Question>();
  final ladderController = new BehaviorSubject<int>();
  final levelController = new BehaviorSubject<int>();
  final titleController = new BehaviorSubject<String>();
  final correctController = new BehaviorSubject<String>();
  final warrningController = new BehaviorSubject<bool>();
  final screenshotController = new ScreenshotController();

  Random _random = new Random();

  Stream<bool> get warningStream => warrningController.stream;

  Sink<bool> get warningSink => warrningController.sink;

  Stream<String> get correctStream => correctController.stream;

  Sink<String> get correctSink => correctController.sink;

  Stream<Question> get questStream => questController.stream;

  Sink<Question> get questSink => questController.sink;

  Stream<String> get titleStream => titleController.stream;

  Sink<String> get titleSink => titleController.sink;

  List<Question> _lstQuestion;

  List<Question> _lstAnswers;

  int _life;

  int get life => _life;

  int _level;

  int get level => _level;

  Question _question;

  Question get question => _question;

  List<String> _listTitle;

  List<String> get listTitle => _listTitle;

  void addSink() {
    questionController.add(_lstQuestion);
    ladderController.add(life);
    levelController.add(_level);
  }

  void dispose() {
    questionController.close();
    ladderController.close();
    levelController.close();
    titleController.close();
    correctController.close();
    questController.close();
    warrningController.close();
  }

  init() async {
    _lstQuestion = await AppShared.getQuestions();
    _lstAnswers = await AppShared.getAnswer();
    getIndexQuest();
    if (await getLife() <= 1) {
      await AppShared.setLife(5);
    }
  }

  showCorrect() async {
    correctSink.add(_question.a);
    await Future.delayed(
      Duration(seconds: 500),
    );
  }

  ///kiển tra có đúng đáp án không
  forwardingQuest(bool check) async {
    if (check) {
      _lstAnswers.add(_question);
      await AppShared.setAnswer(_lstAnswers);
      _lstQuestion.remove(_question);
      await AppShared.setQuestions(_lstQuestion);

      await getLastQuest();
      incrementLevel();
    } else {
      await incrementLife();
    }
    await getLastQuest();
    getIndexQuest();
  }

  /// hết 50 câu hỏi thêm id tiếp theo
  getLastQuest() async {
    if (_lstQuestion.isEmpty) {
      try {
        NetworkState<List<Question>> data;
        data = await repository.getQuestionByIndex(_lstAnswers.length + 1);
        await AppShared.setQuestions(data.data);

        _lstQuestion = await AppShared.getQuestions();
        print("_lstQuestion length ${_lstQuestion.length}");
        await getIndexQuest();
      } catch (e) {
        print("${e}");
      }
    }
  }

  ///tăng mạng
  incrementLife() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_life != null) {
      if (_life <= 1) {
        await AppShared.setLife(5);
        await setLevel();
      } else {
        _life--;
        return await AppShared.setLife(_life);
      }
    } else {
      _life = 5;
    }
  }

  ///lấy mạng
  Future<int> getLife() async {
    _life = await AppShared.getLife();
    return _life;
  }

  /// tăng level
  incrementLevel() {
    _level += 1;
    AppShared.setLevel(_level);
  }

  //lấy level
  Future<int> getLevel() async {
    _level = await AppShared.getLevel();
    return _level;
  }

  //// trở level về ban đầu
  setLevel() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _level = 1;
    return await AppShared.setLevel(_level);
  }

  takeScreenShot() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    final time = DateTime.now().millisecondsSinceEpoch;
    final path = '$directory/screenshot_dovuihainao_$time.png';
    print(path);
    screenshotController.capture(path: path).then(
      (images) async {
        await ImageGallerySaver.saveImage(images.readAsBytesSync());
        ShareExtend.share(images.path, 'images');
      },
    );
  }

  void shareQuestion() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      Toast.show("Đang xử lý...", context, duration: Toast.LENGTH_SHORT);
      await takeScreenShot();
    } else if (status.isDenied)
      Toast.show("Không thể lưu", context, duration: Toast.LENGTH_SHORT);
    else {
      await Permission.storage.request();
      shareQuestion();
    }
  }

  /// lấy 1 câu hỏi ra
  getIndexQuest() {
    try {
      Question quest;
      // int index = _random.nextInt(_lstQuestion.length);
      // _question = _lstQuestion[index];
      _lstQuestion.shuffle();
      quest = _lstQuestion.removeLast();
      _question = quest;

      questSink.add(_question);

      subStringTitle();
    } catch (e) {
      print(e);
    }
  }

  // chọn nhạc
  playSound(GameSound playSound) async {
    print(playSound);
    await service.playSound(playSound);
  }

  subStringTitle() async {
    List<String> text = _question.cauHoi.split("");
    String result = "";
    for (var item in text) {
      await Future.delayed(Duration(milliseconds: 15), () {
        result += item;
        titleSink.add(result);
      });
    }
  }
}
