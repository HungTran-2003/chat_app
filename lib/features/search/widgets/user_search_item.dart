import 'package:chat_app/core/constants/asset_constants.dart';
import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/utlis/tap_guard.dart';
import 'package:chat_app/core/widgets/button/app_icon_button.dart';
import 'package:chat_app/core/widgets/image/app_avatar_image.dart';
import 'package:chat_app/data/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserSearchItem extends StatelessWidget {
  final UserEntity user;
  final VoidCallback? onTap;
  final VoidCallback? onTapDelete;
  const UserSearchItem({
    super.key,
    required this.user,
    this.onTap,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(user.uid ?? 0),
      closeOnScroll: false,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.30,
        children: [
          CustomSlidableAction(
            onPressed: (context) {
              onTapDelete?.call();
              Slidable.of(context)?.close();
            },
            backgroundColor: AppColors.whiteF1F6FA,
            child: AppIconButton(
              path: AssetConstants.iconDelete,
              sizeButton: 36,
              sizeIcon: Size(22, 22),
              backgroundColor: AppColors.backgroundRed,
            ),
          ),
        ],
      ),
      child: Builder(
        builder: (context) {
          final controller = Slidable.of(context);
          if (controller == null) return const SizedBox.shrink();
          return AnimatedBuilder(
            animation: controller.animation,
            builder: (context, child) {
              final double ratio = controller.animation.value.abs();
              final Color bgColor = Color.lerp(
                Colors.transparent,
                AppColors.whiteF1F6FA,
                ratio > 0 ? 1.0 : 0.0,
              )!;
              return Material(color: bgColor, child: child);
            },
            child: InkWell(
              onTap: () => safeAction(() {
                onTap?.call();
              }),
              splashColor: AppColors.whiteF1F6FA,
              child: SizedBox(
                height: 72,
                child: Padding(
                  padding: UiConstants.horizontalPaddingLarge,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppAvatarImage(path: user.avatarPath ?? "", size: 52),
                      12.width,
                      Expanded(child: _buildTitleUser()),
                      8.width,
                      AppIconButton(
                        path: AssetConstants.iconUserPlus,
                        sizeButton: 48,
                        sizeIcon: Size(24, 24),
                        iconColor: AppColors.backgroundDark,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitleUser() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            user.userName ?? "",
            style: AppTextStyle.black.s20.w600,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          Text(
            user.slogan ?? "Lười",
            style: AppTextStyle.grey.s12.w400,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ]
    );
  }
}
