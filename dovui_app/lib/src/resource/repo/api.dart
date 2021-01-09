import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Api {
  static const String base = "http://relax365.net/hsdovuihainao?id=1";
  static const String baseLink = "http://$base";

  static Future<Response>  get(String link, {Map<String, String> params}) async {
    Response response;
    try {
      if (params != null) debugPrint(json.encode(params));
      debugPrint("$link");
      response = await Client().get(
          link.contains("http", 0) ? link : Uri.http(base, link, params));
      debugPrint("response != null : ${response != null}");
    } catch (e) {
      debugPrint("$e");
    }
    return response;
  }

  static Future<Response> post(String link, {Map params}) async {
    Response response;
    try {
      if (params != null) debugPrint(json.encode(params));

      response = await Client().post(
        Uri.http(base, link),
        headers: {"Content-Type": "application/json"},
        body: params != null ? json.encode(params) : null,
      );
      if (response != null) {
        debugPrint("${json.encode(json.decode(response.body))}",
            wrapWidth: 1024);
      }
    } catch (e) {
      debugPrint("$e");
    }
    return response;
  }

  static Future<Response> put(String link,
      {Map<String, dynamic> params}) async {
    debugPrint("$link");
    debugPrint("$params");
    Response response;
    var AppData;
    try {
      String token = await AppData.getAccessToken();

      if (token != null && token.length > 0)
        response = await Client().put(Uri.http(base, link),
            body: params,
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      else
        response = await Client().put(
          Uri.http(base, link),
          body: params,
        );
      if (response != null) {
        debugPrint("${response.body}", wrapWidth: 1024);
      }
    } catch (e) {
      debugPrint("$e");
    }
    return response;
  }

  static Future<Response> delete(
      String link, {Map<String, String> params}) async {
    var AppData;
    String token = await AppData.getAccessToken();
    if (token != null && token.length > 0) {
      return await Client().delete(Uri.http(base, link, params),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    } else
      return await Client().delete(Uri.http(base, link, params));
  }

  static BuildContext mainContext;

  static setContext(BuildContext context) {
    mainContext = context;
  }

  static Future<Response> postMutiplePart(String link,
      {List<MultipartFile> files, Map<String, String> params}) async {
    try {
      var AppData;
      final request = MultipartRequest("POST", Uri.http(base, link));
      String token = await AppData.getAccessToken();
      Map<String, String> headers = {
        HttpHeaders.authorizationHeader: "Bearer $token",
        "Content-Type": "multipart/form-data"
      };
      request.headers.addAll(headers);
      if (params != null) request.fields.addAll(params);
      if (files != null) request.files.addAll(files);
      final streamedResponse = await request.send();
      Response response;
      if (streamedResponse != null)
        response = await Response.fromStream(streamedResponse);
      if (response != null) {
        debugPrint("${response.body}");
      }
      return response;
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }

  static Future<Response> putMutiplePart(String link,
      {List<MultipartFile> files, Map<String, String> params}) async {
    try {
      var AppData;
      final request = MultipartRequest("PUT", Uri.http(base, link));
      String token = await AppData.getAccessToken();
      Map<String, String> headers = {
        HttpHeaders.authorizationHeader: "Bearer $token",
        "Content-Type": "multipart/form-data"
      };
      request.headers.addAll(headers);
      if (params != null) request.fields.addAll(params);
      if (files != null) request.files.addAll(files);
      final streamedResponse = await request.send();
      Response response;
      if (streamedResponse != null)
        response = await Response.fromStream(streamedResponse);
      if (response != null) {
        debugPrint("${response.body}");
      }
      return response;
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }
}