import 'dart:developer';

import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/data/service/supabase/app_supabase_client.dart';
import 'package:chat_app/domain/models/entities/message_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MessageRepository {
  Stream<Either<Failure, List<MessageEntity>>> getRoomMessagesRealtime({required String roomId});
  Future<Either<Failure, void>> sendMessage({required String roomId, required String content});
}

class MessageRepositoryImpl implements MessageRepository {
  final AppSupabaseClient client;

  MessageRepositoryImpl({required this.client});

  @override
  Stream<Either<Failure, List<MessageEntity>>> getRoomMessagesRealtime({required String roomId}) {
    return client.getRoomMessagesRealtime(roomId: roomId).map<Either<Failure, List<MessageEntity>>>(
      (messages) {
        return Right(messages);
      },
    ).handleError((e) {
      log('Error get room messages realtime: $e');
      return Left(FailureMapper.map(e));
    });
  }

  @override
  Future<Either<Failure, void>> sendMessage({required String roomId, required String content}) async {
    try {
      await client.sendMessage(roomId: roomId, content: content);
      return const Right(null);
    } catch (e) {
      log('Error send message: $e');
      return Left(FailureMapper.map(e));
    }
  }
}
