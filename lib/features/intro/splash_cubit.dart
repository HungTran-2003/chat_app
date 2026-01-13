import 'package:chat_app/features/intro/spash_navigation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashNavigator navigator;

  SplashCubit({required this.navigator}) : super(const SplashState());
}
