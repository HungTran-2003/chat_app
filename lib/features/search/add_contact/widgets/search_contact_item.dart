import 'package:chat_app/core/constants/asset_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/button/app_button_wrapper.dart';
import 'package:chat_app/core/widgets/button/app_icon_button.dart';
import 'package:chat_app/core/widgets/image/app_avatar_image.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class SearchContactItem extends StatelessWidget {
  final UserEntity user ;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  const SearchContactItem({
    super.key,
    required this.user,
    this.onTap,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return AppButtonWrapper(
      onPressed: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteF3F5F9,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            AppAvatarImage(
              path: user.avatarPath,
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.userName ?? '',
                    style: AppTextStyle.black.s18.w700,
                  ),
                  4.height,
                  Text(
                    user.slogan ?? S.of(context).message_user_have_not_slogan,
                    style: AppTextStyle.grey.s14.w400.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  8.height,
                ],
              ),
            ),
            10.width,
            AppIconButton(
              path: AssetConstants.iconUserPlus,
              onPress: onAdd,
              backgroundColor: AppColors.primary,
            )
          ],
        ),
      ),
    );
  }
}
