import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CallChildPage();
  }
}

class CallChildPage extends StatefulWidget {
  const CallChildPage({super.key});

  @override
  State<CallChildPage> createState() => _CallChildPageState();
}

class _CallChildPageState extends State<CallChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Placeholder(),
      backgroundColor: AppColors.backgroundDark,
    );
  }
}

