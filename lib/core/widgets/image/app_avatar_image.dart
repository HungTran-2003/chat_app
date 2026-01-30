import 'package:chat_app/core/widgets/image/app_network_image.dart';
import 'package:flutter/material.dart';

class AppAvatarImage extends StatelessWidget {
  final String? path;
  final double? size;
  final BoxFit? fit;
  final Color? borderColor;
  final double? borderWidth;

  const AppAvatarImage({
    super.key,
    this.path = " ",
    this.size = 58,
    this.fit = BoxFit.cover,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor!,
          width: borderWidth!,
        )
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth == 0 ? 0 : 2),
        child: ClipOval(
          child: AppNetworkImage(imageUrl: path!, fit: fit!),
        )
      ),
    );
  }
}
