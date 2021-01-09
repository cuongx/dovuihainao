import 'package:dovui_app/src/configs/constanst/app_images.dart';
import 'package:dovui_app/src/configs/constanst/app_size_config.dart';
import 'package:dovui_app/src/presentation/widgets/widget_answers.dart';
import 'package:dovui_app/src/presentation/widgets/widget_continue.dart';
import 'package:dovui_app/src/presentation/widgets/widget_question.dart';
import 'package:dovui_app/src/resource/model/question.dart';
import 'package:dovui_app/src/resource/services/sound_service.dart';
import 'package:dovui_app/src/resource/services/wifi_service.dart';
import 'package:dovui_app/src/utils/app_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import '../presentation.dart';
import 'homepage_viewmodel.dart';
import 'package:vector_math/vector_math.dart' as math;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

/// nếu sử dụng cho một đối tượng thì dùng SingleTickerProviderStateMixin
/// còn để cho nhiều đối tượng sử dụng thì dùng TickerProviderStateMixin
class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  HomePageViewModel _viewModel;
  Question lstQuest;
  AnimationController _dialogController;
  AnimationController _homeController;
  Animation<double> _animationHome;
  int life;
  int level;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _homeController.forward();
    _animationHome = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_homeController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _homeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppSizeConfig().init(context);
    return BaseWidget<HomePageViewModel>(
        viewModel: HomePageViewModel(
            repository: Provider.of(context), service: Provider.of(context)),
        onViewModelReady: (viewModel) async {
          _viewModel = viewModel;
          await _viewModel.init();
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SafeArea(
                child: StreamBuilder(
              stream: _viewModel.questStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: WidgetCircleProgress(),
                  );
                } else {
                  lstQuest = snapshot.data;
                  return _buildBody();
                }
              },
            )),
          );
        });
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBoard(),
          ],
        ),
      ),
    );
  }

  Widget _buildBoard() {
    return Screenshot(
        controller: _viewModel.screenshotController,
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                AppImages.backGround2,
              ),
              fit: BoxFit.fill,
            )),
            child: Column(
              children: [
                _buildAppBarLife(),
                FutureBuilder<int>(
                    future: _viewModel.getLevel(),
                    builder: (BuildContext context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            level = snapshot.data;
                            return StreamBuilder<String>(
                                stream: _viewModel.titleController.stream,
                                builder: (context, snapshots) {
                                  if (snapshots.hasError) {
                                    return Text("Error ${snapshots.error}");
                                  }
                                  return SizeTransition(
                                    axisAlignment: 10,
                                    sizeFactor: _animationHome,
                                    child: WidgetQuestion(
                                      level: level,
                                      title: snapshots.data,
                                    ),
                                  );
                                });
                          }
                      }
                    }),
                SizedBox(
                  child: _buildAnswerbar(),
                ),
              ],
            )));
  }

  Widget _buildAppBarLife() {
    return Stack(
      children: [_topBackGround(), _buildLife()],
    );
  }

  Widget _topBackGround() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.only(top: 5),
      height: 70,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          AppImages.gameBar,
        ),
        fit: BoxFit.fill,
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Widget_Getsture(
            onTap: () {
              setState(() {
                _viewModel.service.playSound(GameSound.Back);
                Navigator.of(context).pop(Routers.splash);
              });
            },
            width: 20,
            height: 40,
            images: AppImages.btnBack,
            subImages: AppImages.btnBack2,
          )),
          Spacer(
            flex: 4,
          ),
          Expanded(
            child: Widget_Getsture(
              onTap: () {
                _viewModel.service.playSound(GameSound.Back);
                _viewModel.shareQuestion();
              },
              width: 20,
              height: 45,
              images: AppImages.btnScreeenshot,
              subImages: AppImages.btnScreenshot2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLife() {
    return Positioned(
        top: 18,
        left: MediaQuery.of(context).size.width / 1 / 2 - 28,
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  AppImages.heart,
                  width: 35,
                  height: 45,
                ),
                SizedBox(
                  width: 5,
                ),
                FutureBuilder<int>(
                  future: _viewModel.getLife(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                        break;
                      default:
                        if (snapshot.hasError) {
                          return Text("Error ${snapshot.error}");
                        } else {
                          life = snapshot.data;
                          return Text(
                            "${life}",
                            style: Theme.of(context).accentTextTheme.headline5,
                          );
                        }
                    }
                  },
                )
              ],
            ),
          ],
        ));
  }

  //Kiểm tra trả lời đúng hay sai
  checkCorrect(value) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      await _showDialog("LỖI KẾT NỐI MẤT RỒI", AppImages.imgLoseFace,
          AppImages.imgLoseHand, false);
      return Navigator.pop(context);
    } else {
      _viewModel.showCorrect();
      await Future.delayed(Duration(microseconds: 500));
      if (value) {
        /// nếu trả lời đúng
        victorySubject(value);
      } else {
        //nếu trả lời sai
        // nếu life bằng 1 thì thêm warrning
        if (await AppShared.getLife() <= 1) {
          warningBox(value);
        } else {
          lostSubject(value);
        }
      }
    }
    // AppShared.setWarning(false);
  }

  /// Trả lời đúng
  victorySubject(bool value) async {
    _viewModel.playSound(GameSound.Right);
    dynamic result = await _showDialog(lstQuest.giaiThich,
        AppImages.imgVictoryFace, AppImages.imgVictoryHand, true);
    if (result) await _viewModel.forwardingQuest(value);
  }

  //Trả lời sai
  lostSubject(bool value) async {
    _viewModel.playSound(GameSound.Wrong);
    dynamic result = await _showDialog(
      lstQuest.giaiThich,
      AppImages.imgLoseFace,
      AppImages.imgLoseHand,
      false,
    );
    if (result) await _viewModel.forwardingQuest(value);
  }

  /// Hộp cảnh báo khi Life <= 1
  warningBox(bool value) async {
    _viewModel.playSound(GameSound.Wrong);
    dynamic result = await _showDialog(
        lstQuest.giaiThich,
        AppImages.imgLoseFace,
        AppImages.imgLoseHand,
        false,
        "Hết mạng, quay lại cấp độ 1");
    if (result) await _viewModel.forwardingQuest(value);
  }

  Widget _buildAnswerbar() {
    List<String> listQuest = listAnswer();
    print(lstQuest.a);
    return SizeTransition(
      sizeFactor: _animationHome,
      axisAlignment: 35,
      axis: Axis.horizontal,
      child: StreamBuilder<String>(
          stream: _viewModel.correctStream,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.only(top: 45.0),
              child: Column(children: [
                WidgetAnswers(
                  value: listQuest[0],
                  icon: AppImages.imgA,
                  action: (value) async {
                    await checkCorrect(value);
                  },
                  showCorrect: snapshot.data,
                  showAnswer: lstQuest.a,
                ),
                WidgetAnswers(
                  value: listQuest[1],
                  icon: AppImages.imgB,
                  action: (value) async {
                    await checkCorrect(value);
                  },
                  showAnswer: lstQuest.a,
                  showCorrect: snapshot.data,
                ),
                WidgetAnswers(
                  value: listQuest[2],
                  icon: AppImages.imgC,
                  action: (value) async {
                    await checkCorrect(value);
                  },
                  showCorrect: snapshot.data,
                  showAnswer: lstQuest.a,
                ),
                WidgetAnswers(
                  icon: AppImages.imgD,
                  value: listQuest[3],
                  action: (value) async {
                    await checkCorrect(value);
                  },
                  showCorrect: snapshot.data,
                  showAnswer: lstQuest.a,
                ),
              ]),
            );
          }),
    );
  }

  dynamic _showDialog(String text, String image, String icon, bool check,
      [String warning]) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: const Color(0xFF0E3311).withOpacity(0.1),
          body: Container(
              margin: EdgeInsets.only(top: 80),
              height: 500,
              color: const Color(0xFF0E3311).withOpacity(0.1),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    AppImages.start,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                      width: 200,
                      alignment: Alignment(0, 0),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  _buildBackGroundShowdialog(check, text, warning),
                  _buildAnimatedShowdialog(check, icon),
                  _buildContinueShowdialog(check),
                ],
              )),
        );
      },
    );
    // return await showGeneralDialog (barrierColor: Colors.black.withOpacity(0.5),
    //
    //       transitionBuilder: (context, a1, a2, widget)  {
    //
    //         final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
    //             return  Transform(
    //               // angle: math.radians(a1.value * 360),
    //               transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
    //               child: Scaffold(
    //                     backgroundColor: const Color(0xFF0E3311).withOpacity(0.1),
    //                     body: Container(
    //                       width: double.infinity,
    //                         margin: EdgeInsets.only(top: 80),
    //                         height: 500,
    //                         color: const Color(0xFF0E3311).withOpacity(0.1),
    //                         child: Stack(
    //                           alignment: Alignment.topCenter,
    //                           children: [
    //                             Image.asset(
    //                               AppImages.start,
    //                             ),
    //                             Container(
    //                               alignment: Alignment.topCenter,
    //                               child: Image.asset(
    //                                 image,
    //                                 fit: BoxFit.contain,
    //                                 width: 200,
    //                                 alignment: Alignment(0, 0),
    //                               ),
    //                             ),
    //                             SizedBox(
    //                               height: 200,
    //                             ),
    //                             _buildBackGroundShowdialog(check, text, warning),
    //                             _buildAnimatedShowdialog(check, icon),
    //                             _buildContinueShowdialog(check),
    //                           ],
    //                         )),
    //                   ),
    //             );
    //       },
    //       transitionDuration: Duration(milliseconds: 200),
    //       barrierDismissible: true,
    //       barrierLabel: '',
    //       context: context,
    //       pageBuilder: (context, animation1, animation2) {});
  }

  /// Ảnh nền showdialog
  Widget _buildBackGroundShowdialog(bool check, String text, [String warning]) {
    return Positioned(
        right: MediaQuery.of(context).size.width / 2 / 8,
        top: check ? 170 : 180,
        height: AppSizeConfig.screenHeight / 1 / 3.8,
        width: AppSizeConfig.screenWidth / 1 / 1.1,
        child: Container(
            width: AppSizeConfig.screenWidth = double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/board2.png"),
                    fit: BoxFit.fill,
                    alignment: Alignment(1.2, 2))),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    warning ?? "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )));
  }

  /// Icon và Animation Showdialog
  Widget _buildAnimatedShowdialog(bool check, String icon) {
    Animation<double> _animation;
    _dialogController = AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: this,
        lowerBound: 0.3,
        upperBound: 0.6);
    _dialogController.repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _dialogController,
      curve: Curves.ease,
    );
    return Positioned(
      top: check ? 21 : 23,
      left: check
          ? AppSizeConfig.screenLeft * 4.5
          : AppSizeConfig.screenLeft * 9.7,
      child: AnimatedBuilder(
        animation: _dialogController,
        builder: (context, child) {
          return ScaleTransition(
            alignment: Alignment(0, 0),
            scale: _animation,
            child: child,
          );
        },
        child: Image.asset(
          icon,
          fit: BoxFit.fill,
          height: check ? 125 : 90,
        ),
      ),
    );
  }

  ///Thanh chơi tiếp hoặc lùi lại
  Widget _buildContinueShowdialog(bool check) {
    return Positioned(
      top: check
          ? AppSizeConfig.screenHeight * 0.5 - 27
          : AppSizeConfig.screenHeight * 0.5 - 18,
      height: AppSizeConfig.screenHeight = 55,
      child: check
          ? Widget_Continue(
              onTap: () {
                _dialogController.stop();
                _dialogController.dispose();
                Navigator.pop(context, true);
              },
              images: AppImages.continue1,
              subImages: AppImages.continue2,
            )
          : Widget_Continue(
              onTap: () {
                _dialogController.stop();
                _dialogController.dispose();
                Navigator.pop(context, true);
              },
              images: AppImages.playagin1,
              subImages: AppImages.playagin2,
            ),
    );
  }

  List<String> listAnswer() {
    List<String> listAnswer = ["a", "b", "c", "d"];
    listAnswer[0] = lstQuest.a;
    listAnswer[1] = lstQuest.b;
    listAnswer[2] = lstQuest.c;
    listAnswer[3] = lstQuest.d;
    listAnswer.shuffle();
    return listAnswer;
  }
}
