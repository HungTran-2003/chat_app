import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:equatable/equatable.dart';

class ContactRequestDetailState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus overLayStatus;
  final UserEntity? user;

  final String errorMessage;

  const ContactRequestDetailState({
    this.loadStatus = LoadStatus.initial,
    this.overLayStatus = LoadStatus.initial,
    this.user,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [loadStatus, overLayStatus, user, errorMessage];

  ContactRequestDetailState copyWith({
    LoadStatus? loadStatus,
    LoadStatus? overLayStatus,
    UserEntity? user,
    String? errorMessage,
  }) {
    return ContactRequestDetailState(
      loadStatus: loadStatus ?? this.loadStatus,
      overLayStatus: overLayStatus ?? this.overLayStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
