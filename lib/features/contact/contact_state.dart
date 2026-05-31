part of 'contact_cubit.dart';

class ContactState extends Equatable {
  final LoadStatus loadDataStatus;
  final bool isLoadMore;
  final int page;
  final bool hasMore;

  ///Data
  final List<UserEntity> contacts;

  const ContactState({
    this.loadDataStatus = LoadStatus.initial,
    this.isLoadMore = false,
    this.page = 1,
    this.hasMore = true,
    this.contacts = const [],
  });

  @override
  List<Object?> get props => [loadDataStatus, isLoadMore, page, hasMore, contacts];

  ContactState copyWith({
    LoadStatus? loadDataStatus,
    bool? isLoadMore,
    int? page,
    bool? hasMore,
    List<UserEntity>? contacts,
  }) {
    return ContactState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      contacts: contacts ?? this.contacts,
    );
  }
}
