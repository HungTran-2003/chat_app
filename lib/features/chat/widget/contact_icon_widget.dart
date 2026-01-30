import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/image/app_avatar_image.dart';
import 'package:chat_app/data/enum/background_color.dart';
import 'package:chat_app/data/models/user_entity.dart';
import 'package:flutter/material.dart';

class ContactIconWidget extends StatelessWidget {
  final UserEntity user;

  const ContactIconWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = BackgroundColor.getBackgroundColors(
      user.backgroundColor,
    );
    return Column(
      children: [
        AppAvatarImage(
          path: user.avatarPath,
          borderColor: backgroundColor.color,
          borderWidth: 2,
        ),
        10.height,
        Text(user.userName ?? "", style: AppTextStyle.white.titleMedium.w500),
      ],
    );
  }
}
