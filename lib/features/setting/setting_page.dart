import 'package:chat_app/core/global/user/user_cubit.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/features/setting/setting_cubit.dart';
import 'package:chat_app/features/setting/setting_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingCubit>(
      create: (context) => SettingCubit(SettingNavigator(context: context)),
      child: SettingChildPage(),
    );
  }
}

class SettingChildPage extends StatefulWidget {
  const SettingChildPage({super.key});

  @override
  State<SettingChildPage> createState() => _SettingChildPageState();
}

class _SettingChildPageState extends State<SettingChildPage> {
  late SettingCubit _cubit;
  late UserCubit _userCubit;

  @override
  void initState() {
    _userCubit = BlocProvider.of(context);
    _cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () async {
            await _userCubit.logOut();
            _cubit.navigator.openLoginPage();
          },
          child: const Text("Setting Page"),
        ),
      ),
      backgroundColor: AppColors.backgroundDark,
    );
  }
}
