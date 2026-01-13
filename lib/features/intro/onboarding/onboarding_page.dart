import 'dart:math' as math;

import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/features/intro/onboarding/onboarding_cubit.dart';
import 'package:chat_app/features/intro/onboarding/onboarding_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (context) {
        return OnboardingCubit(navigator: OnboardingNavigator(context: context));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyPage(),
      backgroundColor: AppColors.onboardingBackground,
    );
  }

  Widget _buildBodyPage() {
    final maxWidth = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        _buildDecorativeGradient(maxWidth),
      ],
    );
  }

  Widget _buildDecorativeGradient(double maxWidth){
    final width = maxWidth * 1.8;
    final height = maxWidth * 0.6;
    return Transform.rotate(
      angle: -134.23 * math.pi / 360,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gradientStart,
              AppColors.gradientEnd,
            ]
          ),
          borderRadius: BorderRadius.all(Radius.elliptical(width / 2, height / 2)),
        ),
      ),
    );
  }
}

