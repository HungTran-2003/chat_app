import 'dart:async';

import 'package:chat_app/data/repositories/contact_repository.dart';
import 'package:chat_app/domain/models/entities/contact_entity.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/data/repositories/auth_repository.dart';
import 'package:chat_app/features/search/add_contact/add_contact_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_contact_state.dart';

class AddContactCubit extends Cubit<AddContactState> {
  final AddContactNavigator navigator;
  final ContactRepository contactRepo;

  ///Controller
  final searchController = TextEditingController();
  Timer? _debounce;

  AddContactCubit({required this.navigator, required this.contactRepo})
    : super(const AddContactState());

  Future<void> initFetchData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    final result = await contactRepo.getRecentContacts();
    result.fold(
      (error) {
        emit(state.copyWith(loadDataStatus: LoadStatus.failure));
      },
      (contacts) {
        emit(
          state.copyWith(
            loadDataStatus: LoadStatus.success,
            contacts: contacts,
          ),
        );
      },
    );
  }

  void search(String keyword) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      if (keyword.isEmpty) {
        return;
      }
      final contact = state.contacts.where((element) {
        return element.username!.contains(keyword);
      }).toList();

      emit(state.copyWith(loadDataStatus: LoadStatus.loading));
      final result = await contactRepo.searchUser(keyword);
      result.fold(
        (failure) => emit(state.copyWith(loadDataStatus: LoadStatus.failure)),
        (users) => emit(
          state.copyWith(
            loadDataStatus: LoadStatus.success,
            users: users,
            searchContacts: contact,
          ),
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    searchController.dispose();
    return super.close();
  }
}
