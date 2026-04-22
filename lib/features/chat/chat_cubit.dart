import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/domain/models/entities/chat_entity.dart';
import 'package:chat_app/domain/models/entities/contact_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {

  ChatCubit() : super(const ChatState());

  void fetchData() async {
    emit(state.copyWith(loadContactStatus: LoadStatus.loading));

    emit(
      state.copyWith(
        loadContactStatus: LoadStatus.success,
        chats: ChatEntity.mockData(),
      ),
    );
  }
}
