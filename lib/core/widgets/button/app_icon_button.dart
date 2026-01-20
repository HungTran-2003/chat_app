import 'package:chat_app/core/utlis/tap_guard.dart';
import 'package:chat_app/core/widgets/image/app_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIconButton extends StatelessWidget {
  final String path;
  final Size? sizeIcon;
  final double? sizeButton;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? borderWidth;
  final VoidCallback? onPress;

  const AppIconButton({
    super.key,
    required this.path,
    this.sizeIcon = const Size(24, 24),
    this.sizeButton = 48.0,
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    this.iconColor,
    this.borderWidth = 1.0,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => safeAction(() {
        onPress?.call();
      }),
      customBorder: const CircleBorder(),
      child: Ink(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor!, width: borderWidth!),
        ),
        child: SizedBox(
          width: sizeButton,
          height: sizeButton,
          child: Center(
            child: AppSvgImage(
              path,
              width: sizeIcon!.width,
              height: sizeIcon!.height,
              colorFilter: iconColor != null
                  ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                  : null,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
