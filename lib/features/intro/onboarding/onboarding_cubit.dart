import 'package:chat_app/features/intro/onboarding/onboarding_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingNavigator navigator;

  OnboardingCubit({required this.navigator}) : super(const OnboardingState());
}
