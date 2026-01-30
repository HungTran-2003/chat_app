
import 'package:chat_app/core/constants/asset_constants.dart';
import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/utlis/time_utlis.dart';
import 'package:chat_app/core/widgets/badge/app_badge.dart';
import 'package:chat_app/core/widgets/badge/app_status_dot.dart';
import 'package:chat_app/core/widgets/button/app_icon_button.dart';
import 'package:chat_app/core/widgets/image/app_avatar_image.dart';
import 'package:chat_app/data/enum/chat_type.dart';
import 'package:chat_app/data/models/chat_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChatListItem extends StatelessWidget {
  final ChatEntity chatRoom;
  final VoidCallback? onTap;
  final VoidCallback? onTapNotification;
  final VoidCallback? onTapDelete;

  const ChatListItem({
    super.key,
    required this.chatRoom,
    this.onTap,
    this.onTapNotification,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(chatRoom.id ?? 0),
      closeOnScroll: false,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.30,
        children: [
          CustomSlidableAction(
            onPressed: (context) {
              onTapNotification?.call();
              Slidable.of(context)?.close();
            },
            backgroundColor: AppColors.whiteF1F6FA,
            child: AppIconButton(
              path: AssetConstants.iconNotification,
              sizeButton: 36,
              sizeIcon: Size(22, 22),
              backgroundColor: AppColors.backgroundDark,
            ),
          ),
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
          return AnimatedBuilder(
            animation: controller!.animation,
            builder: (context, child) {
              final double ratio = controller.animation.value.abs();
              final Color bgColor = Color.lerp(
                  Colors.transparent,
                  AppColors.whiteF1F6FA,
                  ratio > 0 ? 1.0 : 0.0
              )!;
              return InkWell(
                onTap: onTap,
                splashColor: AppColors.whiteF1F6FA,
                child: Container(
                  color: bgColor,
                  height: 72,
                  child: Padding(
                    padding: UiConstants.horizontalPaddingLarge,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildAvatarChat(),
                        12.width,
                        Expanded(child: _buildLastMessage()),
                        _buildUnreadMessage(),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAvatarChat() {

    Widget? avatar;
    if(chatRoom.avatarGroup != null) {
      avatar = AppAvatarImage(
        path: chatRoom.avatarGroup!,
        size: 52,);
    } else if(chatRoom.type == ChatType.group) {
      avatar = _buildAvatarGroup();
    } else {
      avatar = AppAvatarImage(
        path: chatRoom.users?.first.avatarPath ?? "",
        size: 52,);
    }

    return Stack(
      children: [
        avatar,
        Positioned(
          right: 6,
          bottom: 2,
          child: AppStatusDot(isOnline: chatRoom.isOnline),
        ),
      ],
    );
  }

  Widget _buildAvatarGroup(){
    final avatars = chatRoom.users?.map((u) => u.avatarPath).toList() ?? [];
    final size = 52.0;
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            if (avatars.isNotEmpty)
              Positioned(
                left: 0,
                width: size/2,
                height: size,
                child: _avatar(avatars[0]!),
              ),

            if (avatars.length > 1)
              Positioned(
                right: 0,
                top: 0,
                width: size * 0.5,
                height: avatars.length > 2 ? size * 0.5 : size,
                child: _avatar(avatars[1]!),
              ),

            if (avatars.length > 2)
              Positioned(
                right: 0,
                bottom: 0,
                width: size * 0.5,
                height: size * 0.5,
                child: _avatar(avatars[2]!),
              ),
          ],
        ),
      ),
    );
  }

  Widget _avatar(String url) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLastMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          chatRoom.chatName ?? "",
          style: AppTextStyle.black.s20.w600,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        Text(
          chatRoom.lastMessage?.context ?? "",
          style: AppTextStyle.grey.s12.w400,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildUnreadMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          TimeUtils.getTextTimeLastMessage(chatRoom.lastMessage?.createdAt),
          style: AppTextStyle.grey.s12.w400,
        ),
        7.height,
        if (chatRoom.unreadCount != null && chatRoom.unreadCount! > 0)
          AppBadge(text: chatRoom.unreadCount.toString()),
      ],
    );
  }
}
