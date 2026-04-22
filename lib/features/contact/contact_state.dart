part of 'contact_cubit.dart';

class ContactState extends Equatable {
  final LoadStatus? loadDataStatus;

  ///Data
  final List<ContactEntity>? contacts;

  const ContactState({this.loadDataStatus, this.contacts = const []});

  @override
  List<Object?> get props => [loadDataStatus, contacts];

  ContactState copyWith({
    LoadStatus? loadDataStatus,
    List<ContactEntity>? contacts,
  }) {
    return ContactState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      contacts: contacts ?? this.contacts,
    );
  }
}
