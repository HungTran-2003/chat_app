import 'package:chat_app/data/enum/status_type.dart';
import 'package:chat_app/data/models/chat_entity.dart';
import 'package:chat_app/data/models/contact_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {

  ChatCubit() : super(const ChatState());

  void fetchData() async {
    emit(state.copyWith(loadContactStatus: LoadStatus.loading));

    emit(
      state.copyWith(
        loadContactStatus: LoadStatus.success,
        contacts: ContactEntity.mockData(),
        chats: ChatEntity.mockData(),
      ),
    );
  }
}
