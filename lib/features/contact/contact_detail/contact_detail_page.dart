import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/features/contact/contact_detail/contact_detail_cubit.dart';
import 'package:chat_app/features/contact/contact_detail/contact_detail_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactDetailArgument {
  final String userId;
  final String? userName;
  final String? avatarUrl;

  ContactDetailArgument({
    required this.userId,
    this.userName,
    this.avatarUrl,
  });
}

class ContactDetailPage extends StatelessWidget {
  final ContactDetailArgument argument;

  const ContactDetailPage({
    super.key,
    required this.argument,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactDetailCubit(
        navigator: ContactDetailNavigator(context: context),
        userRepo: context.read(),
        argument: argument,
      )..init(),
      child: const ContactDetailChildPage(),
    );
  }
}

class ContactDetailChildPage extends StatefulWidget {
  const ContactDetailChildPage({super.key});

  @override
  State<ContactDetailChildPage> createState() => _ContactDetailChildPageState();
}

class _ContactDetailChildPageState extends State<ContactDetailChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: const Center(
        child: Text('Contact Detail Page'),
      ),
    );
  }
}
