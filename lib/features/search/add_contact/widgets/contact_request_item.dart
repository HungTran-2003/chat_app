import 'package:chat_app/core/constants/asset_constants.dart';
import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/utlis/tap_guard.dart';
import 'package:chat_app/core/widgets/button/app_button_wrapper.dart';
import 'package:chat_app/core/widgets/button/app_icon_button.dart';
import 'package:chat_app/core/widgets/image/app_avatar_image.dart';
import 'package:chat_app/domain/models/entities/contact_entity.dart';
import 'package:flutter/material.dart';

class ContactRequestItem extends StatelessWidget {
  final ContactEntity contact;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const ContactRequestItem({
    super.key,
    required this.contact,
    this.height = 72,
    this.width,
    this.onTap,
    this.onAccept,
    this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return AppButtonWrapper(
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(

        )
      ),
    );
  }

}
