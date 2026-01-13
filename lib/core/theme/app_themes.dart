import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static const _font = 'app.dart';

  ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary,
      fontFamily: _font,
    );
  }
}