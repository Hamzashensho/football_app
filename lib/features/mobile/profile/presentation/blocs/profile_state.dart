part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState{}

final class ProfileError extends ProfileState{
  final String message;
  ProfileError({required this.message});
}

final class ProfileSuccess extends ProfileState{
  final UserEntity userEntity;
  ProfileSuccess({required this.userEntity});
}


final class EditProfileLoading extends ProfileState{}

final class EditProfileError extends ProfileState{
  final String message;
  EditProfileError({required this.message});
}

final class EditProfileSuccess extends ProfileState{
  final UserEntity userEntity;
  EditProfileSuccess({required this.userEntity});
}