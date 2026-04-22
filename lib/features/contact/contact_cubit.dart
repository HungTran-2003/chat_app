import 'package:chat_app/data/repositories/user_repository.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/features/contact/contact_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "contact_state.dart";

class ContactCubit extends Cubit<ContactState> {
  final ContactNavigator navigator;
  final UserRepository userRepo;


  ContactCubit({
    required this.navigator,
    required this.userRepo,
  }) : super(const ContactState());

  Future<void> fetchData() async {
    emit(state.copyWith(
      loadDataStatus: LoadStatus.loading,
      page: 1,
      hasMore: true,
    ));
    final result = await userRepo.getFriends(page: 1);
    result.fold(
      (failure) {
        emit(state.copyWith(loadDataStatus: LoadStatus.failure));
        navigator.showErrorDialog(message: failure.message);
      },
      (contacts) {
        emit(state.copyWith(
          loadDataStatus: LoadStatus.success,
          contacts: contacts,
          hasMore: contacts.length >= 10,
        ));
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadMore || state.loadDataStatus.isLoading) {
      return;
    }

    emit(state.copyWith(isLoadMore: true));

    final nextPage = state.page + 1;
    final result = await userRepo.getFriends(page: nextPage);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoadMore: false));
      },
      (newContacts) {
        emit(state.copyWith(
          isLoadMore: false,
          page: nextPage,
          contacts: [...state.contacts, ...newContacts],
          hasMore: newContacts.length >= 10,
        ));
      },
    );
  }
}
