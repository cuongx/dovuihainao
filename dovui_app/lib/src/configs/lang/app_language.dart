import 'package:flutter/material.dart';
import 'language_model.dart';

class AppLanguage {
  AppLanguage._();

  static List<LanguageModel> getSupportLanguage() {
    return List<LanguageModel>.of([
      LanguageModel(
        language: 'Vietnamese',
        code: 'vi',
        locale: Locale('vi', 'VN'),
      ),
      LanguageModel(
        language: 'English',
        code: 'en',
        locale: Locale('en', 'US'),
      ),
    ]);
  }

  static LanguageModel getDefaultLanguage() {
    return  LanguageModel(
      language: 'Vietnamese',
      code: 'vi',
      locale: Locale('vi', 'VN'),
    );
  }
}