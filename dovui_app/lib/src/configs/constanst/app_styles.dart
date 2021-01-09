import 'package:flutter/material.dart';

class AppStyles {
  static const String FONT_MONTSERRAT = "Montserrat";
  static const String FONT_SHRIKHAND = "Shrikhand";

  static const FONT_SIZE_VERY_SMALL = 10.0;
  static const FONT_SIZE_SMALL = 12.0;
  static const FONT_SIZE_MEDIUM = 15.0;
  static const FONT_SIZE_LARGE = 20.0;

  static const TEXT_HEIGHT = 1.2;

  static const DEFAULT_SMALL =
      TextStyle(fontSize: FONT_SIZE_SMALL, height: TEXT_HEIGHT);
  static const DEFAULT_MEDIUM =
      TextStyle(fontSize: FONT_SIZE_MEDIUM, height: TEXT_HEIGHT);
  static const DEFAULT_LARGE =
      TextStyle(fontSize: FONT_SIZE_LARGE, height: TEXT_HEIGHT);

  static final DEFAULT_SMALL_BOLD =
      DEFAULT_SMALL.copyWith(fontWeight: FontWeight.bold);
  static final DEFAULT_MEDIUM_BOLD =
      DEFAULT_MEDIUM.copyWith(fontWeight: FontWeight.bold,fontFamily: "Itim");
  static final DEFAULT_LARGE_BOLD =
      DEFAULT_LARGE.copyWith(fontWeight: FontWeight.bold);
}
