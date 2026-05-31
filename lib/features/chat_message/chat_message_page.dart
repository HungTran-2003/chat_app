import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/image/app_avatar_image.dart';
import 'package:chat_app/data/repositories/message_repository.dart';
import 'package:chat_app/domain/models/entities/room_entity.dart';
import 'package:chat_app/domain/models/entities/message_entity.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/core/global/user/user_cubit.dart';
import 'package:chat_app/features/chat_message/chat_message_cubit.dart';
import 'package:chat_app/features/chat_message/chat_message_state.dart';
import 'package:chat_app/features/chat_message/chat_message_navigator.dart';
import 'package:chat_app/core/utlis/time_utlis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessagePage extends StatelessWidget {
  final RoomEntity room;

  const ChatMessagePage({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatMessageCubit(
        navigator: ChatMessageNavigator(context: context),
        messageRepo: RepositoryProvider.of<MessageRepository>(context),
        room: room,
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
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final ChatMessageCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ChatMessageCubit>();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSend() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      _cubit.sendMessage(text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildListMessage()),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final room = _cubit.room;
    final String? avatarUrl = room.avatarGroup.isNotEmpty ? room.avatarGroup.first : null;
    
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leadingWidth: 40,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textBlack, size: 20),
        onPressed: () => _cubit.navigator.pop(),
      ),
      title: Row(
        children: [
          AppAvatarImage(path: avatarUrl, size: 40),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  room.roomName ?? "Chat",
                  style: AppTextStyle.black.s16.w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Active now",
                  style: AppTextStyle.grey.s10.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.phone_outlined, color: AppColors.textBlack),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam_outlined, color: AppColors.textBlack),
          onPressed: () {},
        ),
        8.width,
      ],
    );
  }

  Widget _buildListMessage() {
    final currentUserId = context.read<UserCubit>().state.user?.uid;

    return BlocBuilder<ChatMessageCubit, ChatMessageState>(
      builder: (context, state) {
        if (state.loadMessagesStatus == LoadStatus.loading && state.messages == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state.loadMessagesStatus == LoadStatus.failure && state.messages == null) {
          return Center(
            child: Text(
              "Failed to load messages",
              style: AppTextStyle.grey.s14,
            ),
          );
        }

        final messages = state.messages ?? [];

        if (messages.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 64,
                  color: AppColors.greyCD,
                ),
                16.height,
                Text(
                  "No messages yet. Say hello! 👋",
                  style: AppTextStyle.grey.s14.bold,
                ),
              ],
            ),
          );
        }

        // We use reverse: true so that the list is scrolled to the bottom by default.
        // We reverse the list in memory because our stream outputs oldest first.
        final reversedMessages = List<MessageEntity>.from(messages).reversed.toList();

        return ListView.separated(
          controller: _scrollController,
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: reversedMessages.length,
          separatorBuilder: (context, index) => 16.height,
          itemBuilder: (context, index) {
            final message = reversedMessages[index];
            final isMe = message.senderId == currentUserId;
            
            if (isMe) {
              return _buildMessageBubble(
                message: message.context ?? "",
                isMe: true,
                time: TimeUtils.getTextTimeLastMessage(message.createdAt),
              );
            } else {
              return _buildMessageBubbleWithAvatar(
                message: message.context ?? "",
                isMe: false,
                time: TimeUtils.getTextTimeLastMessage(message.createdAt),
                senderName: state.room?.roomName ?? "Other User",
                avatarUrl: state.room?.avatarGroup.isNotEmpty == true 
                    ? state.room!.avatarGroup.first 
                    : null,
              );
            }
          },
        );
      },
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
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isMe ? AppColors.primary : const Color(0xFFF2F7FB),
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
    required String? avatarUrl,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppAvatarImage(path: avatarUrl, size: 40),
        12.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(senderName, style: AppTextStyle.black.s12.bold),
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
              child: TextField(
                controller: _messageController,
                onSubmitted: (_) => _onSend(),
                textInputAction: TextInputAction.send,
                decoration: const InputDecoration(
                  hintText: "Write your message",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
          ),
          12.width,
          GestureDetector(
            onTap: _onSend,
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.send_rounded, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
