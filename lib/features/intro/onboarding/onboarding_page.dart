import 'dart:math' as math;
import 'dart:ui';

import 'package:chat_app/core/constants/asset_constants.dart';
import 'package:chat_app/core/constants/ui_constants.dart';
import 'package:chat_app/core/extensions/num_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
import 'package:chat_app/core/widgets/button/app_filled_button.dart';
import 'package:chat_app/core/widgets/button/app_icon_button.dart';
import 'package:chat_app/core/widgets/divider/app_divider.dart';
import 'package:chat_app/core/widgets/image/app_assest_image.dart';
import 'package:chat_app/core/widgets/image/app_svg_image.dart';
import 'package:chat_app/core/widgets/text/app_text_rich.dart';
import 'package:chat_app/features/auth/widgets/divider/auth_divider_with_text.dart';
import 'package:chat_app/features/intro/onboarding/onboarding_cubit.dart';
import 'package:chat_app/features/intro/onboarding/onboarding_navigator.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (context) {
        return OnboardingCubit(
          navigator: OnboardingNavigator(context: context),
        );
      },
      child: OnboardingChildPage(),
    );
  }
}

class OnboardingChildPage extends StatefulWidget {
  const OnboardingChildPage({super.key});

  @override
  State<OnboardingChildPage> createState() => _OnboardingChildPageState();
}

class _OnboardingChildPageState extends State<OnboardingChildPage> {
  late OnboardingCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyPage(),
      backgroundColor: AppColors.onboardingBackground,
    );
  }

  Widget _buildBodyPage() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -10,
          left: -10,
          child: AppAssetImage(
            path: AssetConstants.backgroundBlur,
            fit: BoxFit.cover,
          ),
        ),

        SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: UiConstants.paddingExtraLarge.paddingHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  17.height,
                  _buildAppTitle(),
                  44.height,
                  _buildTitlePage(),
                  16.height,
                  Text(
                    S.of(context).onboard_description,
                    style: AppTextStyle.grey.s16.w500,
                  ),
                  38.height,
                  _buildButtonAuthIcon(),
                  30.height,
                  AuthDividerWithText(),
                  30.height,
                  AppFilledButton(
                    label: S.of(context).common_sign_up_with_email,
                    onPress: () {
                      _cubit.navigator.goToRegisterPage();
                    },
                    backgroundColor: AppColors.backgroundLight,
                    labelStyle: AppTextStyle.black.s14.w500,
                  ),
                  46.height,
                  AppTextRich(
                    rawText: S.of(context).common_have_account_login,
                    styles: [AppTextStyle.white.s14.w700],
                    defaultStyle: AppTextStyle.grey.s14.w500,
                    onPress: [_handlerLogin],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppTitle() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppSvgImage(AssetConstants.appIcon, width: 16, height: 19),
        6.width,
        Text(
          S.of(context).common_app_title,
          style: AppTextStyle.white.s14.w500,
        ),
      ],
    );
  }

  Widget _buildTitlePage() {
    return AppTextRich(
      rawText: S.of(context).onboard_app_title,
      styles: [AppTextStyle.white.s68.w700],
      defaultStyle: AppTextStyle.white.s68.w500,
    );
  }

  Widget _buildButtonAuthIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        AppIconButton(
          path: AssetConstants.iconFacebook,
          borderColor: AppColors.borderGrayA8B,
        ),

        AppIconButton(
          path: AssetConstants.iconGoogle,
          borderColor: AppColors.borderGrayA8B,
        ),

        AppIconButton(
          path: AssetConstants.iconApple,
          borderColor: AppColors.borderGrayA8B,
        ),
      ],
    );
  }

  void _handlerLogin() {
    _cubit.navigator.goToLoginPage();
  }
}
