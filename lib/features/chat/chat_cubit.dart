import 'package:chat_app/data/repositories/room_repository.dart';
import 'package:chat_app/domain/models/entities/room_entity.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/domain/models/entities/contact_entity.dart';
import 'package:chat_app/features/chat/chat_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatNavigator navigator;
  final RoomRepository roomRepo;

  ChatCubit({required this.navigator, required this.roomRepo})
    : super(const ChatState());

  void fetchData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    final result = await roomRepo.getUserRooms();
    result.fold(
      (error) {
        emit(state.copyWith(loadDataStatus: LoadStatus.failure));
        navigator.showErrorDialog(message: error.message);
      },
      (response) {
        emit(
          state.copyWith(loadDataStatus: LoadStatus.success, rooms: response),
        );
      },
    );
  }
}
