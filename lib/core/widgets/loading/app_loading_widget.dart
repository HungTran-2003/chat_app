import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppLoadingWidget extends StatelessWidget {
  final Size? size;
  final Color? color;

  const AppLoadingWidget({
    super.key,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size?.width ?? 20,
        height: size?.height ?? 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
        ),
      ),
    );
  }
}
