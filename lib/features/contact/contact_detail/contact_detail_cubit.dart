import 'package:chat_app/data/repositories/user_repository.dart';
import 'package:chat_app/features/contact/contact_detail/contact_detail_navigator.dart';
import 'package:chat_app/features/contact/contact_detail/contact_detail_page.dart';
import 'package:chat_app/features/contact/contact_detail/contact_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactDetailCubit extends Cubit<ContactDetailState> {
  final ContactDetailNavigator navigator;
  final UserRepository userRepo;
  final ContactDetailArgument argument;

  ContactDetailCubit({
    required this.navigator,
    required this.userRepo,
    required this.argument,
  }) : super(const ContactDetailState());

  void init() {
    // Sử dụng argument.userId
  }
}
