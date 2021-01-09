import 'package:flutter/material.dart';

class LanguageModel {
  LanguageModel({this.locale, this.code, this.language});

  final Locale locale;
  final String code;
  final String language;
}