part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpFailed extends AuthState {
  final String message;

  SignUpFailed(this.message);
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailed extends AuthState {
  final String message;

  LoginFailed(this.message);
}

class LoginWithGoogleLoading extends AuthState {}

class LoginWithGoogleSuccess extends AuthState {}

class LoginWithGoogleFailed extends AuthState {
  final String message;

  LoginWithGoogleFailed(this.message);
}


 class Unauthenticated extends AuthState {}


class GetCurrentUserLoading extends AuthState {}

class GetCurrentUserLoaded extends AuthState {}

class GetCurrentUserFailed extends AuthState {
  final String message;

  GetCurrentUserFailed(this.message);
}

class SendResetPasswordEmailSuccess extends AuthState {}

class SendResetPasswordEmailFailed extends AuthState {
  final String message;

  SendResetPasswordEmailFailed(this.message);
}

class SendResetPasswordEmailLoading extends AuthState {}
class SignOutLoading extends AuthState {}
class SignOutSuccess extends AuthState {}
class SignOutFailed extends AuthState {
  final String message;

  SignOutFailed(this.message);
}