part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class GetUser extends ProfileEvent{}

final class EditUser extends ProfileEvent{
  final UserEntity userEntity;
  EditUser({required this.userEntity});
}