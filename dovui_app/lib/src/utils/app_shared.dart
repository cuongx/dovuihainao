import 'dart:async';
import 'dart:convert';
import 'package:dovui_app/src/resource/model/question.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppShared {
  static const String keyQuestion = "question";
  static const String keyAnswer = "answer";
  static const String keyLevel = "level";
  static const String keyLife = "life";
  static const String keySound = "sound";
  static const String keyWarning = "warning";
  static final prefs = RxSharedPreferences(SharedPreferences.getInstance());

  static const String keyAccessToken = "keyAccessToken";
  static const String keyProcess = "keyProcess";

  static Future<bool> setAccessToken(String token) =>
      prefs.setString(keyAccessToken, token);

  static Future<String> getAccessToken() => prefs.getString(keyAccessToken);

  static Future<bool> setQuestions(List<Question> questions) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = questions != null ? jsonEncode(questions) : "";
    return prefs.setString(keyQuestion, json);
  }

  static Future<List<Question>> getQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = prefs.getString(keyQuestion);
    if (json != null && !json.isEmpty) {
      print("gia tri sau khi set question:" + json);
      return Question.listFromJson(jsonDecode(json));
    } else {
      return [];
    }
  }

  static Future<bool> setAnswer(List<Question> questions) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = questions != null ? jsonEncode(questions) : "";
    return prefs.setString(keyAnswer, json);
  }

  static Future<List<Question>> getAnswer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = prefs.getString(keyAnswer);
    if (json != null && !json.isEmpty) {
      print("gia tri sau khi set Answer:" + json);
      return Question.listFromJson(jsonDecode(json));
    } else {
      return [];
    }
  }

  static Future<bool> getSound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool select = prefs.getBool(keySound);
    if (select == null) {
      return true;
    }
    ;
    return select;
  }

  static Future<bool> setSound(bool sound) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(keySound, sound).then((bool success) {});
  }

  static Future<int> getLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int count = 1;
    count = prefs.getInt(keyLevel) ?? 1;
    return count;
  }

  static Future<bool> setLevel(int level) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyLevel, level).then((bool success) {
      return level;
    });
  }

  static Future<bool> setLife(int life) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(keyLife, life);
  }

  static Future<int> getLife() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int life = prefs.getInt(keyLife) ?? 1;
    return life;
  }

  static Future<bool> setWarning(bool select) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(keyWarning, select);
  }

  static Future<bool> getWarning() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool warning = prefs.getBool(keyWarning);
    if (warning == null) return false;
    return warning;
  }
}
