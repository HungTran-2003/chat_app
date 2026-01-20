import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordNotifier extends ChangeNotifier {
  bool _isObscure = true;
  String? _textError;

  bool get isObscure => _isObscure;
  String? get textError => _textError;

  void toggleVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void setTextError(String? textError) {
    _textError = textError;
    notifyListeners();
  }
}

class PasswordTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextStyle? labelStyle;
  final FocusNode? focusNode;
  final EdgeInsets? padding;
  final TextStyle? style;
  final PasswordNotifier passwordNotifier;

  const PasswordTextField({
    super.key,
    this.label = "TextField",
    this.controller,
    this.validator,
    this.maxLines,
    this.labelStyle,
    this.focusNode,
    this.padding,
    this.style,
    required this.passwordNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = InputDecoration(
      label: Transform.translate(
        offset: const Offset(0, -16),
        child: Text(label!),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.only(bottom: 8),
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
      suffixIcon: IconButton(
        icon: Icon(
          passwordNotifier.isObscure
              ? Icons.visibility_off
              : Icons.visibility,
        ),
        onPressed: () {
          passwordNotifier.toggleVisibility();
        },
      ),
      helperText: " "
    );
    return ListenableBuilder(
      listenable: passwordNotifier,
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller,
              obscureText: passwordNotifier.isObscure,
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
                  passwordNotifier.textError ?? "",
                  style: AppTextStyle.red.s14.w500,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
