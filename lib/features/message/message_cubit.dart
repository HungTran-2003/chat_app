import 'package:chat_app/data/enum/status_type.dart';
import 'package:chat_app/data/models/chat_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(const MessageState());

  void fetchData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));

    emit(state.copyWith(chats: ChatEntity.mockData(), loadDataStatus: LoadStatus.success));
  }
}