import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/divider/app_divider.dart';
import 'package:flutter/material.dart';

class AuthDividerWithText extends StatelessWidget {
  final String? text;
  final TextStyle? style;

  const AuthDividerWithText({super.key, this.text = "OR", this.style});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: AppDivider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(text!, style: style ?? AppTextStyle.white.s14.w600),
        ),
        const Expanded(child: AppDivider()),
      ],
    );
  }
}
