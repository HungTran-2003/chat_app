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
  final AuthRepository authRepository;

  ///Controller
  final searchController = TextEditingController();

  ///FocusNode
  final searchFocusNode = FocusNode();

  AddContactCubit({required this.navigator, required this.authRepository})
    : super(const AddContactState());

  void initFetchData() {
    final mockData = ContactEntity.mockData();
    emit(
      state.copyWith(
        loadDataStatus: LoadStatus.success,
        contacts: mockData,
        searchContacts: mockData,
      ),
    );
  }

  void search(String keyword) async {
    final result = _searchContact(state.contacts, keyword);
    if (result.isNotEmpty) {
      emit(state.copyWith(searchContacts: result));
    } else {
      _searchUser(keyword);
    }
  }

  List<ContactEntity> _searchContact(List<ContactEntity> data, String keyword) {
    final k = keyword.toLowerCase();
    return data
        .where(
          (e) =>
              e.user?.userName?.toLowerCase().contains(k) == true ||
              e.user?.email?.toLowerCase().contains(k) == true,
        )
        .toList();
  }

  void _searchUser(String keyword) async {
    if (keyword.trim().isEmpty || state.loadDataStatus?.isLoading == true) {
      return;
    }
    emit(state.copyWith(loadDataStatus: LoadStatus.loading, keyWord: keyword));
    // final result = await authRepository.searchUser(keyword: keyword);
    //
    // result.fold(
    //   (failure) {
    //     emit(state.copyWith(loadDataStatus: LoadStatus.success));
    //     navigator.flushbarNavigator.showError(message: failure.message);
    //   },
    //   (success) {
    //     if (keyword == searchController.text.trim()) {
    //       emit(
    //         state.copyWith(loadDataStatus: LoadStatus.success, users: success),
    //       );
    //     }
    //   },
    // );
  }
}
