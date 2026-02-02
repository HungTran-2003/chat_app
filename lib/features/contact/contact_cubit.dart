import 'package:chat_app/data/enum/status_type.dart';
import 'package:chat_app/data/entities/contact_entity.dart';
import 'package:chat_app/features/contact/contact_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "contact_state.dart";

class ContactCubit extends Cubit<ContactState> {
  final ContactNavigator navigator;
  ContactCubit({required this.navigator}) : super(const ContactState());

  void fetchData(){
  }
}
