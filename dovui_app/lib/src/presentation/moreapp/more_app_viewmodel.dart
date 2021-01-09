import 'package:dovui_app/src/resource/model/apps/apps.dart';
import 'package:dovui_app/src/resource/model/apps/other_application.dart';
import 'package:dovui_app/src/resource/model/model.dart';
import 'package:dovui_app/src/resource/repo/other_repository.dart';
import 'package:dovui_app/src/resource/services/wifi_service.dart';
import 'package:flutter/material.dart';


import '../presentation.dart';


class MoreAppViewModel extends  BaseViewModel{
  // NetworkState<OtherApplication> otherApplication;
   OtherRepository repository;

  MoreAppViewModel({@required this.repository});

  Future<List<Apps>> getProducts() async {

      NetworkState<OtherApplication> moreApp = await repository.getMoreApps();
    if(moreApp.data.apps.isEmpty){
      print("null");
    }
    return  moreApp.data.apps;

  }
}

