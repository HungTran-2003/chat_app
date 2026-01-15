
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/utlis/tap_guard.dart';
import 'package:flutter/material.dart';

class AppFilledButton extends StatelessWidget {
  final String label;
  final VoidCallback onPress;
  final TextStyle? labelStyle;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final double? borderRadius;

  const AppFilledButton({
    super.key,
    required this.label,
    required this.onPress,
    this.labelStyle,
    this.backgroundColor = AppColors.primary,
    this.height = 48,
    this.width,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => safeAction(() {
        onPress.call();
      }),
      borderRadius: BorderRadius.circular(borderRadius!),
      child: Ink(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: Center(
          child: Text(label, style: labelStyle ?? AppTextStyle.white.s16.w700),
        ),
      ),
    );
  }
}
