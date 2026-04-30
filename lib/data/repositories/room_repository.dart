import 'dart:developer';

import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/data/service/supabase/app_supabase_client.dart';
import 'package:chat_app/domain/models/entities/room_entity.dart';
import 'package:dartz/dartz.dart';

abstract class RoomRepository {
  Future<Either<Failure, List<RoomEntity>>> getUserRooms();
}

class RoomRepositoryImpl implements RoomRepository {
  final AppSupabaseClient client;

  RoomRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, List<RoomEntity>>> getUserRooms() async {
    try {
      final roomsResponse = await client.getUserRooms();
      final rooms = roomsResponse.map((e) => e.toEntity()).toList();
      return Right(rooms);
    } catch (e) {
      log('Error get user rooms: $e');
      return Left(FailureMapper.map(e));
    }
  }
}
