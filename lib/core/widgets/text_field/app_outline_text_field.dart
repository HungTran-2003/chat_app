import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppOutlineTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final String? errorText;
  final ValueChanged<bool>? onFocusChange;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final double borderRadius;
  final Color? fillColor;
  final bool filled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const AppOutlineTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.labelStyle,
    this.hintStyle,
    this.focusNode,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.style,
    this.errorText,
    this.onFocusChange,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onChanged,
    this.borderRadius = 12,
    this.fillColor = const Color(0xFFF3F5F9),
    this.filled = true,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.trim().isNotEmpty;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide.none,
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: AppColors.backgroundRed, width: 1),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              label!,
              style: labelStyle ?? AppTextStyle.primary.s14.w600.copyWith(
                color: hasError ? AppColors.backgroundRed : AppColors.textBlack,
              ),
            ),
          ),
        Focus(
          onFocusChange: onFocusChange,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            maxLines: maxLines,
            focusNode: focusNode,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: hintStyle ?? AppTextStyle.grey.s16.w400,
              fillColor: fillColor,
              filled: filled,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: contentPadding,
              border: border,
              enabledBorder: border,
              focusedBorder: border.copyWith(
                borderSide: const BorderSide(color: AppColors.primary, width: 1),
              ),
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
              errorStyle: const TextStyle(height: 0, color: Colors.transparent),
            ),
            style: style ?? AppTextStyle.black.s16.w500,
            cursorColor: AppColors.primary,
            textInputAction: textInputAction,
            onFieldSubmitted: onFieldSubmitted,
            inputFormatters: [
              ...(inputFormatters ??
                  [LengthLimitingTextInputFormatter(255)]),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              errorText!,
              style: AppTextStyle.red.s12.w400,
            ),
          ),
      ],
    );
  }
}
