import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  const AppBadge({super.key, this.text, this.color, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? AppColors.backgroundRed,
        shape: BoxShape.circle
      ),
      child: Center(
        child: Text(
          text ?? "",
          style: AppTextStyle.white.s12.w600,
        ),
      ),
    );
  }
}
