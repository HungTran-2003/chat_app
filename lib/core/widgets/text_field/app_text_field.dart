import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class TextFieldNotifier extends ChangeNotifier {
  TextFieldNotifier();

  String? _textError;

  String? get textError => _textError;

  void setTextError(String? textError) {
    _textError = textError;
    notifyListeners();
  }
}

class AppTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final int? maxLines;
  final TextStyle? labelStyle;
  final FocusNode? focusNode;
  final EdgeInsets? padding;
  final TextStyle? style;
  final TextFieldNotifier? textFieldNotifier;

  const AppTextField({
    super.key,
    this.label = "TextField",
    this.controller,
    this.obscureText,
    this.validator,
    this.suffixIcon,
    this.maxLines,
    this.labelStyle,
    this.focusNode,
    this.padding,
    this.style,
    this.textFieldNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = InputDecoration(
      label: Transform.translate(
        offset: const Offset(0, -16),
        child: Text(label!),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.only(bottom: 8),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return labelStyle ?? AppTextStyle.red.s18.w600;
        }
        if (states.contains(WidgetState.focused)) {
          return labelStyle ?? AppTextStyle.primary.s18.w600;
        }
        return AppTextStyle.primary.s18.w600;
      }),

      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.divider, width: 1),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.divider, width: 1),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.backgroundRed, width: 1),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.backgroundRed, width: 1),
      ),
      suffixIcon: suffixIcon,
      errorStyle: AppTextStyle.red.s14.w500,
      helperText: " "
    );

    return ListenableBuilder(
      listenable: textFieldNotifier ?? TextFieldNotifier(),
      builder: (context, child) {
        return Column(
          children: [
            TextFormField(
              controller: controller,
              obscureText: obscureText ?? false,
              validator: validator,
              maxLines: maxLines ?? 1,
              focusNode: focusNode,
              decoration: defaultDecoration,
              style: style ?? AppTextStyle.black.s18.w500,
            ),
            Transform.translate(
              offset: const Offset(0, -20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  textFieldNotifier?.textError ?? "",
                  style: AppTextStyle.red.s14.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
