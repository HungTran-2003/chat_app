import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MessageChildPage();
  }
}

class MessageChildPage extends StatefulWidget {
  const MessageChildPage({super.key});

  @override
  State<MessageChildPage> createState() => _MessageChildPageState();
}

class _MessageChildPageState extends State<MessageChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Placeholder(),
      backgroundColor: AppColors.backgroundDark,
    );
  }
}

