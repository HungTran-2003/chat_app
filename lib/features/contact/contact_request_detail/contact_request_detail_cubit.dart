import 'package:chat_app/data/repositories/contact_repository.dart';
import 'package:chat_app/data/repositories/user_repository.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/features/contact/contact_request_detail/contact_request_detail_navigator.dart';
import 'package:chat_app/features/contact/contact_request_detail/contact_request_detail_page.dart';
import 'package:chat_app/features/contact/contact_request_detail/contact_request_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactRequestDetailCubit extends Cubit<ContactRequestDetailState> {
  final ContactRequestDetailNavigator navigator;
  final UserRepository userRepo;
  final ContactRepository contactRepo;
  final ContactRequestDetailArgument argument;

  ContactRequestDetailCubit({
    required this.navigator,
    required this.argument,
    required this.userRepo,
    required this.contactRepo,
  }) : super(const ContactRequestDetailState());

  Future<void> init() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await userRepo.getOtherUserInfo(
      userId: argument.contact.requestId!,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            loadStatus: LoadStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (user) {
        emit(state.copyWith(loadStatus: LoadStatus.success, user: user));
      },
    );
  }

  void acceptRequest({required String requestId}) async {
    if (state.overLayStatus.isLoading) return;

    emit(state.copyWith(overLayStatus: LoadStatus.loading));
    final result = await contactRepo.acceptRequest(requestId: requestId);

    result.fold(
          (failure) {
        emit(state.copyWith(overLayStatus: LoadStatus.failure));
        navigator.showErrorDialog(message: failure.message);
      },
          (response) {
        emit(
          state.copyWith(
            overLayStatus: LoadStatus.success,
          ),
        );
        navigator.showSuccessSnackBar(message: "Add Success");
      },
    );
  }

  void ignoreRequest({required String requestId}) async {
    if (state.overLayStatus.isLoading) return;
    emit(state.copyWith(overLayStatus: LoadStatus.loading));
    final result = await contactRepo.ignoreRequest(requestId: requestId);
    result.fold(
          (failure) {
        emit(state.copyWith(overLayStatus: LoadStatus.failure));
        navigator.showErrorDialog(message: failure.message);
      },
          (response) {
        emit(
          state.copyWith(
            overLayStatus: LoadStatus.success,
          ),
        );
        navigator.showSuccessSnackBar(message: "Ignore Success");
      },
    );
  }
}
