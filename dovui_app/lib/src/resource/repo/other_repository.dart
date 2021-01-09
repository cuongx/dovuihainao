
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dovui_app/src/resource/model/apps/other_application.dart';
import 'package:dovui_app/src/resource/model/question.dart';
import 'package:dovui_app/src/resource/services/wifi_service.dart';
import 'package:dovui_app/src/utils/app_clients.dart';
import '../../configs/configs.dart';
import '../resource.dart';
import 'dart:io';




class OtherRepository {
  ///http://relax365.net/hsmoreapp?os=
  Future<NetworkState<OtherApplication>> getMoreApps() async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      String api = AppEndpoint.MORE_APPS;
      Map<String, dynamic> params = {
        "os": Platform.isAndroid ? "android" : "ios"
      };
      Response response = await AppClients().get(api, queryParameters: params);
      print(response.data);
      return NetworkState(
        status: AppEndpoint.SUCCESS,
        data: OtherApplication.fromJson(jsonDecode(response.data)),
      );
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  ///http://relax365.net/hsdovuihainao
  Future<NetworkState<List<Question>>> getQuestionByIndex(int index) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      String api = AppEndpoint.GET_QUESTION;
      Map<String, dynamic> params = {"id": index};
      Response response = await AppClients().get(api, queryParameters: params);
      return  NetworkState(
        status: AppEndpoint.SUCCESS,
        data: Question.listFromJson(response.data),
      );
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }

  }

}
