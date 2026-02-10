import 'package:chat_app/core/constants/asset_constants.dart';
import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/utlis/tap_guard.dart';
import 'package:chat_app/core/widgets/button/app_icon_button.dart';
import 'package:chat_app/core/widgets/image/app_avatar_image.dart';
import 'package:chat_app/data/entities/contact_entity.dart';
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
    return InkWell(
      onTap: () => safeAction(() {
        onTap?.call();
      }),
      child: Ink(
        width: width,
        height: height,
        padding: UiConstants.horizontalPaddingLarge,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppAvatarImage(
              path: contact.user?.avatarPath,
            ),
            12.width,
            Expanded(
              child: _buildTitleUser(),
            ),
            6.width,
            _buildButtons()
          ],
        ),
      ),
    );
  }

  Widget _buildTitleUser() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            contact.user?.userName ?? "",
            style: AppTextStyle.black.s20.w600,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          Text(
            contact.user?.slogan ?? "",
            style: AppTextStyle.grey.s12.w400,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ]
    );
  }

  Widget _buildButtons(){
    return Row(
      spacing: 6,
      children: [
        AppIconButton(
          path: AssetConstants.iconUserAccept,
          onPress: onAccept,
          backgroundColor: AppColors.green,
          iconColor: AppColors.whiteF3F6F6,
        ),
        AppIconButton(
          path: AssetConstants.iconUserDecline,
          onPress: onDecline,
          backgroundColor: AppColors.backgroundRed,
          iconColor: AppColors.whiteF3F6F6,
        ),
      ],
    );
  }
}
