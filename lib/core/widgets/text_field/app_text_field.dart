import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLines;
  final TextStyle? labelStyle;
  final FocusNode? focusNode;
  final EdgeInsets? padding;
  final TextStyle? style;
  final String? errorText;
  final ValueChanged<bool>? onFocusChange;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const AppTextField({
    super.key,
    this.label = "TextField",
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines = 1,
    this.labelStyle,
    this.focusNode,
    this.padding,
    this.style,
    this.errorText,
    this.onFocusChange,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.trim().isNotEmpty;

    final defaultDecoration = InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: hasError ? AppColors.backgroundRed : AppColors.divider,
          width: 1,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: hasError ? AppColors.backgroundRed : AppColors.divider,
          width: 1,
        ),
      ),
      suffixIcon: suffixIcon,
      contentPadding: padding,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: labelStyle?.copyWith(
                  color: hasError ? AppColors.backgroundRed : labelStyle?.color,
                ) ??
                AppTextStyle.primary.s14.w600.copyWith(
                  color: hasError ? AppColors.backgroundRed : AppColors.primary,
                ),
          ),
        Focus(
          onFocusChange: onFocusChange,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            maxLines: maxLines,
            focusNode: focusNode,
            decoration: defaultDecoration,
            style: style ?? AppTextStyle.black.s18.w500,
            cursorColor: AppColors.primary,
            textInputAction: textInputAction,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ),
        SizedBox(
          height: 20,
          child: Text(
            hasError ? errorText! : "",
            style: AppTextStyle.red.s14.w500,
          ),
        ),
      ],
    );
  }
}
