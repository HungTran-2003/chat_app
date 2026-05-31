import 'dart:async';

import 'package:chat_app/data/repositories/message_repository.dart';
import 'package:chat_app/domain/models/entities/room_entity.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/features/chat_message/chat_message_navigator.dart';
import 'package:chat_app/features/chat_message/chat_message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageCubit extends Cubit<ChatMessageState> {
  final ChatMessageNavigator navigator;
  final MessageRepository messageRepo;
  final RoomEntity room;
  StreamSubscription? _messagesSubscription;

  ChatMessageCubit({
    required this.navigator,
    required this.messageRepo,
    required this.room,
  }) : super(ChatMessageState(room: room)) {
    _listenToMessages();
  }

  void _listenToMessages() {
    final roomId = room.id;
    if (roomId == null) return;

    emit(state.copyWith(loadMessagesStatus: LoadStatus.loading));
    _messagesSubscription?.cancel();
    _messagesSubscription = messageRepo.getRoomMessagesRealtime(roomId: roomId).listen(
      (result) {
        result.fold(
          (failure) {
            emit(state.copyWith(loadMessagesStatus: LoadStatus.failure));
            navigator.showErrorDialog(message: failure.message);
          },
          (messages) {
            emit(
              state.copyWith(
                loadMessagesStatus: LoadStatus.success,
                messages: messages,
              ),
            );
          },
        );
      },
      onError: (error) {
        emit(state.copyWith(loadMessagesStatus: LoadStatus.failure));
      },
    );
  }

  Future<void> sendMessage(String content) async {
    final roomId = room.id;
    if (roomId == null || content.trim().isEmpty) return;

    emit(state.copyWith(sendMessageStatus: LoadStatus.loading));
    final result = await messageRepo.sendMessage(roomId: roomId, content: content.trim());
    result.fold(
      (failure) {
        emit(state.copyWith(sendMessageStatus: LoadStatus.failure));
        navigator.showErrorSnackBar(message: failure.message);
      },
      (_) {
        emit(state.copyWith(sendMessageStatus: LoadStatus.success));
      },
    );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
