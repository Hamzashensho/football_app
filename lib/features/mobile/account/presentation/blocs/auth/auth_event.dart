part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignInWithFacebookRequested extends AuthEvent {}
class SignInWithGoogleRequested extends AuthEvent {}

class SignInWithEmailRequested extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailRequested({required this.email, required this.password});
}

class SignUpWithEmailRequested extends AuthEvent {
  final String email;
  final String password;
  final UserEntity user;

  SignUpWithEmailRequested({required this.email, required this.password,required this.user});
}

class SignOutRequested extends AuthEvent {}
class GetCurrentUserEvent extends AuthEvent {}

class ResetPassword extends AuthEvent{
  final String email;
  ResetPassword({required this.email});
}