import 'dart:async';

import 'package:chat_app/data/repositories/room_repository.dart';
import 'package:chat_app/domain/models/entities/room_entity.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/features/chat/chat_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/domain/models/entities/contact_entity.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatNavigator navigator;
  final RoomRepository roomRepo;
  StreamSubscription? _roomsSubscription;

  ChatCubit({required this.navigator, required this.roomRepo})
    : super(const ChatState());

  void fetchData() {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    _roomsSubscription?.cancel();
    _roomsSubscription = roomRepo.getUserRooms().listen(
      (result) {
        result.fold(
          (error) {
            emit(state.copyWith(loadDataStatus: LoadStatus.failure));
            navigator.showErrorDialog(message: error.message);
          },
          (response) {
            emit(
              state.copyWith(
                loadDataStatus: LoadStatus.success,
                rooms: response,
              ),
            );
          },
        );
      },
      onError: (error) {
        emit(state.copyWith(loadDataStatus: LoadStatus.failure));
      },
    );
  }

  @override
  Future<void> close() {
    _roomsSubscription?.cancel();
    return super.close();
  }
}
