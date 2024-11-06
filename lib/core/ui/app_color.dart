import 'package:flutter/material.dart';

abstract class AppColor {
  static AppColor get light => _AppColorLigt();

  /// Define your own dark color scheme (if any)
  static AppColor get dark => _AppColorLigt();

  abstract Color primary;
  abstract Color secondary;
  abstract Color tertiary;
  abstract Color surface;
  abstract Color onSurface;
  abstract Color background;
  abstract Color onBackground;
  abstract Color outline;
  abstract Color outlineAlt;
  abstract Color error;
  abstract Color onError;
}

class _AppColorLigt extends AppColor {
  @override
  Color primary = Colors.blue;
  @override
  Color secondary = Colors.amber;
  @override
  Color tertiary = Colors.teal;
  @override
  Color surface = Colors.white;
  @override
  Color onSurface = Colors.black;
  @override
  Color background = Colors.grey.shade50;
  @override
  Color onBackground = Colors.grey.shade800;
  @override
  Color outline = Colors.grey;
  @override
  Color outlineAlt = Colors.grey.shade300;
  @override
  Color error = Colors.red;
  @override
  Color onError = Colors.white;
}
