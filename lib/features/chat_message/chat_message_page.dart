import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/app_bar/base_app_bar.dart';
import 'package:chat_app/core/widgets/image/app_avatar_image.dart';
import 'package:chat_app/features/chat_message/chat_message_cubit.dart';
import 'package:chat_app/features/chat_message/chat_message_navigator.dart';
import 'package:chat_app/features/chat_message/chat_message_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessagePage extends StatelessWidget {
  const ChatMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatMessageCubit(
        navigator: ChatMessageNavigator(context: context),
      ),
      child: const ChatMessageChildPage(),
    );
  }
}

class ChatMessageChildPage extends StatefulWidget {
  const ChatMessageChildPage({super.key});

  @override
  State<ChatMessageChildPage> createState() => _ChatMessageChildPageState();
}

class _ChatMessageChildPageState extends State<ChatMessageChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(child: _buildListMessage()),
          _buildInputBar(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return BaseAppBar(
      titleWidget: Row(
        children: [
          const AppAvatarImage(
            path: null,
            size: 40,
          ),
          12.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Jhon Abraham",
                style: AppTextStyle.black.s16.bold,
              ),
              Text(
                "Active now",
                style: AppTextStyle.grey.s12,
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.call_outlined, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam_outlined, color: Colors.black),
          onPressed: () {},
        ),
        8.width,
      ],
    );
  }

  Widget _buildListMessage() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.greyF3,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text("Today", style: AppTextStyle.black.s12.bold),
          ),
        ),
        24.height,
        _buildMessageBubble(
          message: "Hello! Jhon abraham",
          isMe: true,
          time: "09:25 AM",
        ),
        24.height,
        _buildMessageBubbleWithAvatar(
          message: "Hello ! Nazrul How are you?",
          isMe: false,
          time: "09:25 AM",
          senderName: "Jhon Abraham",
        ),
        24.height,
        _buildMessageBubble(
          message: "You did your job well!",
          isMe: true,
          time: "09:25 AM",
        ),
        // Thêm các bubble khác tương tự như hình mẫu...
      ],
    );
  }

  Widget _buildMessageBubble({
    required String message,
    required bool isMe,
    required String time,
  }) {
    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isMe ? const Color(0xFF20A090) : const Color(0xFFF2F7FB),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(isMe ? 16 : 0),
              bottomRight: Radius.circular(isMe ? 0 : 16),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        4.height,
        Text(time, style: AppTextStyle.grey.s10),
      ],
    );
  }

  Widget _buildMessageBubbleWithAvatar({
    required String message,
    required bool isMe,
    required String time,
    required String senderName,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppAvatarImage(path: null, size: 40),
        12.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(senderName, style: AppTextStyle.black.s14.bold),
              4.height,
              _buildMessageBubble(message: message, isMe: isMe, time: time),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          const Icon(Icons.link, color: Colors.black54),
          12.width,
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F6F6),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Write your message",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
          ),
          12.width,
          const Icon(Icons.copy_rounded, color: Colors.black54),
          12.width,
          const Icon(Icons.camera_alt_outlined, color: Colors.black54),
          12.width,
          const Icon(Icons.mic_none_outlined, color: Colors.black54),
        ],
      ),
    );
  }
}
