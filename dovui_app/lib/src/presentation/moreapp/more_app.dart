import 'package:dovui_app/src/configs/configs.dart';
import 'package:dovui_app/src/presentation/moreapp/more_app_viewmodel.dart';
import 'package:dovui_app/src/presentation/widgets/widget_sepration.dart';
import 'package:dovui_app/src/resource/model/apps/apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../presentation.dart';

class MoreApp extends StatefulWidget {
  @override
  _MoreAppState createState() => _MoreAppState();
}

class _MoreAppState extends State<MoreApp> {
  bool loading = true;
  List<Apps> listApp;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MoreAppViewModel>(
        viewModel: MoreAppViewModel(
          repository: Provider.of(context),
        ),
        builder: (context, viewModel, child) {
          return FutureBuilder(
            future: viewModel.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
                Navigator.pop(context);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                loading = false;
                listApp = snapshot.data;
                return _buildMoreAppPage();
              }
            },
          );
        });

    // TODO: implement build
  }

  _buildMoreAppPage() {
    final _screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Column(
            children: [_buildHeader(), _buildBody()],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/gamebar2.png",
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Image.asset(
          "assets/icons/moreapp.png",
          fit: BoxFit.fill,
          height: 75,
        ),
        Positioned(
            right: 3,
            top: 5,
            child: Widget_Getsture(
              onTap: () {
                Navigator.pop(context);
              },
              images: AppImages.btnBack,
              subImages: AppImages.btnBack2,
              height: 40,
              width: 50,
            ))
      ],
    );
  }

  Widget _buildBody() {
    final _screenSize = MediaQuery.of(context).size;
    return Flexible(
      child: Container(
        height: _screenSize.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage("assets/images/background3.png"),
                fit: BoxFit.fill)),
        child: loading
            ? Center(
                child: Center(
                child: CircularProgressIndicator(),
              ))
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(15),
                itemCount: listApp.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Apps pro = listApp[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          pro.name,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange[600],
                              fontFamily: "Itim"),
                        ),
                        contentPadding: EdgeInsets.all(5),
                        trailing: Widget_Getsture(
                          onTap: () async {
                            await _launchURL(pro.linkdown);
                            print(pro.linkdown);
                          },
                          images: AppImages.download2,
                          subImages: AppImages.download1,
                          width: 100,
                        ),
                        leading: FadeInImage.assetNetwork(
                          image: pro.logolink,
                          placeholder: AppImages.loading,
                          width: 90,
                          height: 90,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 16,top: 5,bottom: 5),
                        child: WidgetSeparation(),
                      )
                    ],
                  );
                },
              ),
      ),
    );
  }

  _launchURL(String linkDowload) async {
    String url = "https://play.google.com/store/apps/details?id=${linkDowload}";
    print(linkDowload);
    if (await canLaunch(url) != null) {
      print(url);
      launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
