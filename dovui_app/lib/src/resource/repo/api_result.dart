import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

typedef dynamic DecodeData(dynamic json);

class ApiResult<T> {
  int status;
  String _msg;
  T data;
  DataType dataType;

  ApiResult(
      {this.status = 0,
      String msg = "Lỗi kết nối, vui lòng thử lại",
      this.data,
      this.dataType = DataType.Object}) {
    this._msg = msg;
  }

  factory ApiResult.fromResponse(Response response, {DecodeData decodeData}) {
    ApiResult<T> apiResult = ApiResult<T>();
    try {
      print("mememe");
      print("${response.body}");
      if (response != null &&
          response.statusCode == 200 &&
          response.body != null) {
        print("coc");
        List<dynamic> result = json.decode(response.body);
        if (result != null) {
          try {
            if (decodeData != null && result != null) {
              apiResult.data = decodeData(result);
              print("kkk");
            }
          } catch (e) {
            debugPrint("$e");
          }
        }
      }
    } catch (e) {
      print("ero");
      debugPrint("$e");
    }
    return apiResult;
  }


  String get msg {
    if (_msg != null) return _msg;
    return "";
  }

  set msg(String value) {
    _msg = value;
  }
}

enum DataType { Object, List }
