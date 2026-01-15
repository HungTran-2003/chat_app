import 'package:chat_app/core/constants/asset_constants.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/widgets/image/app_assest_image.dart';
import 'package:chat_app/core/widgets/image/app_svg_image.dart';
import 'package:chat_app/features/intro/splash/spash_navigation.dart';
import 'package:chat_app/features/intro/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) {
        return SplashCubit(navigator: SplashNavigator(context: context));
      },
      child: const SplashChildPage(),
    );
  }
}

class SplashChildPage extends StatefulWidget {
  const SplashChildPage({super.key});

  @override
  State<SplashChildPage> createState() => _SplashChildPageState();
}

class _SplashChildPageState extends State<SplashChildPage> {
  late SplashCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      _cubit.checkOnboard();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.splashBackground,
      child: Center(
        child: Center(
          child: AppAssetImage(
            path: AssetConstants.logoAppText,
          ),
        ),
      ),
    );
  }
}

