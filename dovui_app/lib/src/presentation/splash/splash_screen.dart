import 'package:dovui_app/src/configs/constanst/app_images.dart';
import 'package:dovui_app/src/configs/constanst/app_size_config.dart';
import 'package:dovui_app/src/presentation/splash/splash.dart';
import 'package:dovui_app/src/resource/services/sound_service.dart';
import 'package:dovui_app/src/resource/services/wifi_service.dart';
import 'package:dovui_app/src/utils/app_shared.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../base/base.dart';
import 'package:provider/provider.dart';
import '../presentation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  SplashViewModel _viewModel;
  bool select = false;


  @override
  Widget build(BuildContext context) {
    AppSizeConfig().init(context);
    return BaseWidget<SplashViewModel>(
        viewModel: SplashViewModel(
            repository: Provider.of(context), service: Provider.of(context)),
        onViewModelReady: (viewModel) async {
          _viewModel = viewModel;
          viewModel.init();
        },
        builder: (context, viewModel, child) {
          return _buildBody(context);
        });
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background1.png"),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHead(),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Image.asset("assets/images/banner.png"),
                ),
                _buldLevel(),
                SizedBox(
                  height: 10,
                ),
                _buldPlay(),
                SizedBox(
                  height: 18,
                ),
                _buildMoreApp()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHead() {
    return Container(
      margin: EdgeInsets.only(right: 15, top: 10),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildShare(),
          SizedBox(
            width: 10,
          ),
          buildLike(),
          SizedBox(
            width: 10,
          ),
          buildTurnOnOff(),
        ],
      ),
    );
  }

  /// nút  share
  Widget buildShare() {
    return Widget_Getsture(
      width: 45,
      onTap: () {
        share(context, "mMEME");
      },
      images: AppImages.linkShared,
      subImages: AppImages.linkShared2,
    );
  }

  ///nút like
  Widget buildLike() {
    return Widget_Getsture(
      width: 45,
      onTap: () {
        _viewModel.service.playSound(GameSound.Back);
        launchURL();
      },
      images: AppImages.likeImage,
      subImages: AppImages.likeImage2,
    );
  }

  ///bật tắt âm thanh
  Widget buildTurnOnOff() {
    return StreamBuilder<bool>(
        stream: _viewModel.streamMusic,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }
          if (snapshot.data == null) {
            return CircularProgressIndicator();
          }
          return GestureDetector(
            onTap: (){
              _viewModel.service.playSound(GameSound.Back);
            },
              child: snapshot.data
                  ? InkWell(
                      onTap: () {
                        _viewModel.checkIMusic(IsMusic.turnOff);
                      },
                      child: Image.asset(AppImages.onVolumn))
                  : InkWell(
                      onTap: () {
                        _viewModel.checkIMusic(IsMusic.turnOn);
                      },
                      child: Image.asset(AppImages.offVolumn)));
        });
  }

  /// Level
  Widget _buldLevel() {
    return FutureBuilder<int>(
      future: AppShared.getLevel(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
            break;
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              print(snapshot.data);
              return Text(
                "Cấp Độ ${snapshot.data}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: "Itim",
                    fontWeight: FontWeight.bold),
              );
            }
        }
      },
    );
  }

///Music
  Widget _buldPlay() {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.playgame2))),
        child: Widget_Getsture(
          width: AppSizeConfig.screenWidth/1.8,
          onTap: () async {
            await _viewModel.service.playSound(GameSound.Play);
            await Navigator.pushNamed(context, Routers.homePage);
            setState(() {});
          },
          images: AppImages.playgame1,
          subImages: AppImages.playgame2,
        ));
  }


  ///MoreApp
  Widget _buildMoreApp() {
    return Widget_Getsture(
      width: AppSizeConfig.screenWidth/1.8,
      onTap: () async {
        bool isDisconnect = await WifiService.isDisconnect();
        if (isDisconnect) {
          showInSnackBar("Check your connection....");
        } else {
          _viewModel.service.playSound(GameSound.MoreApp);
          Navigator.pushNamed(context, Routers.moreapp);
        }
      },
      images: "assets/images/gamehot1.png",
      subImages: "assets/images/gamehot2.png",
    );
  }

  ///Url
  launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.huesoft.dovuihainao';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  share(BuildContext context, String alliGator) {
    final RenderBox box = context.findRenderObject();
    Share.share("Cường - Đẹp zai $alliGator",
        subject: "",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(content: Container(width: 400, child: new Text(value))));
  }
}
