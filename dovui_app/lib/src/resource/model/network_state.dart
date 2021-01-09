import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../configs/configs.dart';

class NetworkState<T> {
  int status;
  String message;
  T data;

  NetworkState({this.message, this.data, this.status});

  NetworkState.fromJson(Map<String, dynamic> json) {
    this.message = json['message'];
    this.status = json['status'];
    this.data = json['data'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }

  NetworkState.withError(DioError error) {
    String message;
    int code;
    print("=========== ERROR ===========");
    print("${error.type}");
    Response response = error.response;
    if (response != null) {
      print("=========== statusCode ===========");
      print("${response.statusCode}");
      code = response.statusCode;
      print("=========== data ===========");
      print("${response.data.toString()}");
      message = response.data["message"];
    } else {
      code = AppEndpoint.ERROR_SERVER;
      print("=========== message ===========");
      print("${error.message}");
      message = "Không thể kết nối đến máy chủ!";
    }
    this.message = message;
    this.status = code;
    this.data = null;
  }

  NetworkState.withDisconnect() {
    print("=========== DISCONNECT ===========");
    this.message =
    "Mất kết nối internet, vui lòng kiểm tra wifi/3g và thử lại!";
    this.status = AppEndpoint.ERROR_DISCONNECT;
    this.data = null;
  }

  bool get isSuccess => status == AppEndpoint.SUCCESS;

  bool get isError => status != AppEndpoint.SUCCESS;
}
