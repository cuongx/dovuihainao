
import 'package:dovui_app/src/presentation/homepage/homepage_viewmodel.dart';
import 'package:dovui_app/src/presentation/presentation.dart';
import 'package:dovui_app/src/utils/app_shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetAppBar {
  static getAppBar(BuildContext context, [Future<int> ladder]) {
    final provider = Provider.of<HomePageViewModel>(context, listen: false);

    // TODO: implement build
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 2),
          height: 200,
          child: Image(
            image: AssetImage(
              'assets/images/gamebar1.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Row(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              //   setState(() {
              Navigator.of(context).pop(Routers.splash);
              //   });
            },
            child: Image.asset(
              "assets/icons/btnback.png",
              width: 20,
              height: 45,
            ),
          )),
          Spacer(
            flex: 2,
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/heart.png",
                width: 30,
                height: 35,
              ),
              StreamBuilder(
                  stream: provider.ladderController.stream,
                  builder: (context,snapshot){
                    return  Text("${snapshot.data!=0?snapshot.data:1}");
                  })
              // FutureBuilder<int>(
              //   future: AppShared.getLadder(),
              //   builder: (context, AsyncSnapshot<int> snapshot) {
              //     switch (snapshot.connectionState) {
              //       case ConnectionState.waiting:
              //         return CircularProgressIndicator();
              //         break;
              //       default:
              //         if (snapshot.hasError) {
              //           return Text("Error ${snapshot.error}");
              //         } else {
              //           return Text("${snapshot.data}");
              //         }
              //     }
              //   },
              // )
            ],
          )),
          Spacer(
            flex: 2,
          ),
          Expanded(
              child: Image.asset(
            "assets/icons/btnscreenshot.png",
            width: 15,
            height: 45,
          ))
        ],
      ),
    );
  }
}
