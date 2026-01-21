import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ContactChildPage();
  }
}

class ContactChildPage extends StatefulWidget {
  const ContactChildPage({super.key});

  @override
  State<ContactChildPage> createState() => _ContactChildPageState();
}

class _ContactChildPageState extends State<ContactChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Placeholder(),
      backgroundColor: AppColors.backgroundDark,
    );
  }
}
