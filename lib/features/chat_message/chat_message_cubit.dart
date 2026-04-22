import 'package:chat_app/features/chat_message/chat_message_navigator.dart';
import 'package:chat_app/features/chat_message/chat_message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageCubit extends Cubit<ChatMessageState> {
  final ChatMessageNavigator navigator;

  ChatMessageCubit({required this.navigator}) : super(const ChatMessageState());
}
