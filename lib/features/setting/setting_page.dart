import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingChildPage();
  }
}

class SettingChildPage extends StatefulWidget {
  const SettingChildPage({super.key});

  @override
  State<SettingChildPage> createState() => _SettingChildPageState();
}

class _SettingChildPageState extends State<SettingChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Placeholder(),
      backgroundColor: AppColors.backgroundDark,
    );
  }
}

