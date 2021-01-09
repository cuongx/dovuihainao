import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dovui_app/src/resource/model/apps/apps.dart';
import 'package:dovui_app/src/resource/model/apps/other_application.dart';
import 'package:dovui_app/src/resource/model/question.dart';
import 'package:dovui_app/src/resource/repo/api.dart';
import 'package:dovui_app/src/resource/repo/api_result.dart';
import 'package:http/http.dart' as http;




class Services {
  static const String url = 'https://relax365.net/hsmoreapp?os=android';

  static List<Apps> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody)["apps"].cast<Map<String, dynamic>>();
    return parsed.map<Apps>((json) => Apps.fromJson(json)).toList();
  }

  static Future<List<Apps>> fetchProducts() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return parseProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  static Future<ApiResult<List<Question>>> getAllProvince(String id) async {
    return ApiResult.fromResponse(
        await Api.get('https://relax365.net/hsdovuihainao?id=$id',),
        decodeData: (json) => Question.listFromJson(json));
  }
  static Future<ApiResult<List<Apps>>> getAllProvinces() async {
    return ApiResult.fromResponse(
        await Api.get('https://relax365.net/hsmoreapp?os=android',),
        decodeData: (json) => OtherApplication.fromJson(json));
  }


}



