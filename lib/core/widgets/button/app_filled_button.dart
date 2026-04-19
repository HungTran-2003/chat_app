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
  final bool? enable;

  const AppFilledButton({
    super.key,
    required this.label,
    required this.onPress,
    this.labelStyle,
    this.backgroundColor = AppColors.primary,
    this.height = 48,
    this.width,
    this.borderRadius = 16,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    final styleDefault = enable == true
        ? AppTextStyle.white.s18.w600
        : AppTextStyle.white.s18.w600.copyWith(color: AppColors.tertiary);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        enableFeedback: true,
        onTap: enable == true
            ? () => safeAction(() {
                onPress.call();
              })
            : null,
        borderRadius: BorderRadius.circular(borderRadius!),
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: enable == true ? backgroundColor : AppColors.whiteF3F6F6,
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          child: Center(child: Text(label, style: labelStyle ?? styleDefault)),
        ),
      ),
    );
  }
}
