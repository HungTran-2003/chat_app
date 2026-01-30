import 'package:chat_app/core/widgets/image/app_assest_image.dart';
import 'package:flutter/material.dart';

class AppImageButton extends StatelessWidget {
  final String path;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final VoidCallback? onPress;

  const AppImageButton({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      customBorder: const CircleBorder(),
      child: Ink(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        width: width,
        height: height,
        child: AppAssetImage(
          path: path,
          fit: fit,
        ),
      ),
    );
  }
}
