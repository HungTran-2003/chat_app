import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

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
    final String? avatarUrl = room.avatarGroup.isNotEmpty
        ? room.avatarGroup.first
        : null;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leadingWidth: 40,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.textBlack,
          size: 20,
        ),
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
                  style: AppTextStyle.grey.s10.copyWith(
                    color: AppColors.primary,
                  ),
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
      buildWhen: (previous, current) =>
          previous.loadMessagesStatus != current.loadMessagesStatus ||
          previous.messages != current.messages,
      builder: (context, state) {
        if (state.loadMessagesStatus == LoadStatus.loading &&
            state.messages == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state.loadMessagesStatus == LoadStatus.failure &&
            state.messages == null) {
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

        final reversedMessages = List<MessageEntity>.from(
          messages,
        ).reversed.toList();

        return ListView.separated(
          controller: _scrollController,
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: reversedMessages.length,
          separatorBuilder: (context, index) => 16.height,
          itemBuilder: (context, index) {
            final message = reversedMessages[index];
            final isMe = message.senderId == currentUserId;
            print(currentUserId);

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
    final bool isUrl = message.startsWith('http://') || message.startsWith('https://');
    
    Widget bubbleContent;

    if (isUrl) {
      if (message.contains('/image/upload/') || 
          _hasExtension(message, ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp', '.heic', '.heif'])) {
        // --- IMAGE MESSAGE ---
        bubbleContent = ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
              maxHeight: 250,
            ),
            child: CachedNetworkImage(
              imageUrl: message,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 200,
                height: 150,
                color: const Color(0xFFF3F6F6),
                child: const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 200,
                height: 150,
                color: const Color(0xFFF3F6F6),
                child: const Center(
                  child: Icon(Icons.broken_image, color: Colors.grey, size: 32),
                ),
              ),
            ),
          ),
        );
      } else if (message.contains('/video/upload/') || 
                 _hasExtension(message, ['.mp4', '.mov', '.avi', '.mkv', '.webm', '.3gp'])) {
        // --- VIDEO MESSAGE ---
        bubbleContent = Container(
          width: 200,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMe ? AppColors.primary : const Color(0xFFF2F7FB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: isMe ? Colors.white.withValues(alpha: 0.2) : AppColors.primary.withValues(alpha: 0.1),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: isMe ? Colors.white : AppColors.primary,
                  size: 24,
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Video",
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Nhấp để xem",
                      style: TextStyle(
                        color: isMe ? Colors.white70 : Colors.black54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else if (_hasExtension(message, ['.mp3', '.m4a', '.wav', '.aac', '.ogg', '.flac'])) {
        // --- AUDIO / VOICE RECORDING MESSAGE ---
        bubbleContent = Container(
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isMe ? AppColors.primary : const Color(0xFFF2F7FB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.mic,
                color: isMe ? Colors.white : AppColors.primary,
                size: 24,
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tin nhắn thoại",
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Nhấp để nghe",
                      style: TextStyle(
                        color: isMe ? Colors.white70 : Colors.black54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        // --- OTHER RAW FILES / DOCUMENTS ---
        final fileName = message.split('/').last.split('?').first;
        bubbleContent = Container(
          width: 220,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMe ? AppColors.primary : const Color(0xFFF2F7FB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.insert_drive_file_rounded,
                color: isMe ? Colors.white : AppColors.primary,
                size: 28,
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Nhấp để mở",
                      style: TextStyle(
                        color: isMe ? Colors.white70 : Colors.black54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    } else {
      // --- STANDARD TEXT MESSAGE ---
      bubbleContent = Container(
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
      );
    }

    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        bubbleContent,
        4.height,
        Text(time, style: AppTextStyle.grey.s10),
      ],
    );
  }

  bool _hasExtension(String path, List<String> extensions) {
    final lowerPath = path.toLowerCase().split('?').first;
    return extensions.any((ext) => lowerPath.endsWith(ext));
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
          GestureDetector(
            onTap: _showAttachmentOptions,
            child: const Icon(Icons.link, color: Colors.black54),
          ),
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
                minLines: 1,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Write your message",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
          ),
          12.width,
          BlocBuilder<ChatMessageCubit, ChatMessageState>(
            buildWhen: (previous, current) =>
                previous.sendMessageStatus != current.sendMessageStatus,
            builder: (context, state) {
              if (state.sendMessageStatus == LoadStatus.loading) {
                return const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                );
              }
              return GestureDetector(
                onTap: _onSend,
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.send_rounded, color: Colors.white, size: 18),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // --- Attachment Picking Helpers ---

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Đính kèm tệp tin",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[850],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOptionItem(
                      icon: Icons.camera_alt_rounded,
                      color: Colors.blue,
                      label: "Máy ảnh",
                      onTap: () {
                        Navigator.pop(context);
                        _pickFromCamera();
                      },
                    ),
                    _buildOptionItem(
                      icon: Icons.photo_library_rounded,
                      color: Colors.purple,
                      label: "Thư viện",
                      onTap: () {
                        Navigator.pop(context);
                        _pickFromGallery();
                      },
                    ),
                    _buildOptionItem(
                      icon: Icons.folder_open_rounded,
                      color: Colors.orange,
                      label: "Tài liệu",
                      onTap: () {
                        Navigator.pop(context);
                        _pickDocument();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFromCamera() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? file = await picker.pickImage(source: ImageSource.camera);
      if (file != null) {
        _cubit.uploadAndSendMedia(file.path);
      }
    } catch (e) {
      _showErrorSnackBar("Không thể mở máy ảnh: $e");
    }
  }

  Future<void> _pickFromGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        _cubit.uploadAndSendMedia(file.path);
      }
    } catch (e) {
      _showErrorSnackBar("Không thể mở thư viện: $e");
    }
  }

  Future<void> _pickDocument() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );
      if (result != null && result.files.single.path != null) {
        _cubit.uploadAndSendMedia(result.files.single.path!);
      }
    } catch (e) {
      _showErrorSnackBar("Không thể chọn tệp tin: $e");
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
