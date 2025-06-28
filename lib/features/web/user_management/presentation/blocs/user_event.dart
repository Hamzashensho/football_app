part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UserEvent {}
// Add other user-related events here (e.g., AddUser, UpdateUser, DeleteUser)

