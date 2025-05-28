import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/mobile/account/domain/repositories/auth_repository.dart';
import 'package:sport_app_user/features/mobile/account/domain/usecases/get_current_user.dart';
import 'package:sport_app_user/features/mobile/account/domain/usecases/reset_password.dart';
import 'package:sport_app_user/features/mobile/account/domain/usecases/sign_in_with_email.dart';
import 'package:sport_app_user/features/mobile/account/domain/usecases/sign_in_with_google.dart';
import 'package:sport_app_user/features/mobile/account/domain/usecases/sign_out.dart';
import 'package:sport_app_user/features/mobile/account/domain/usecases/sign_up_with_email.dart';
import 'package:sport_app_user/injection_container.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInWithFacebookRequested>(_onFacebookSignIn);
    on<SignInWithGoogleRequested>(_onGoogleSignIn);
    on<SignInWithEmailRequested>(_onEmailSignIn);
    on<SignUpWithEmailRequested>(_onEmailSignUp);
    on<SignOutRequested>(_onSignOut);
    on<GetCurrentUserEvent>(_onGetCurrentUser);
    on<ResetPassword>(_onResetPassword);
  }

  Future<void> _onFacebookSignIn(
    SignInWithFacebookRequested event,
    Emitter<AuthState> emit,
  ) async {
    // emit(AuthLoading());
    // final result = await SignInWithFacebook(
    //   sl<AuthRepository>(),
    // ).call(NoParams());
    // result.fold(
    //   (failure) => emit(AuthError(failure.message)),
    //   (user) => emit(Authenticated(user)),
    // );

  }

  Future<void> _onGoogleSignIn(
      SignInWithGoogleRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(LoginWithGoogleLoading());
    final result = await SignInWithGoogle(
      sl<AuthRepository>(),
    ).call(NoParams());
    result.fold(
          (failure) => emit(LoginWithGoogleFailed(failure.message)),
          (user) => emit(LoginWithGoogleSuccess()),
    );
  }

  Future<void> _onEmailSignIn(
    SignInWithEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginLoading());
    final result = await SignInWithEmail(
      sl<AuthRepository>(),
    ).call(SignInWithEmailParams(email: event.email, password: event.password));

    result.fold(
      (failure) => emit(LoginFailed(failure.message)),
      (user) => emit(LoginSuccess()),
    );
  }

  Future<void> _onEmailSignUp(
    SignUpWithEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(SignUpLoading());
    final result = await SignUpWithEmail(
      sl<AuthRepository>(),
    ).call(SignInWithEmailParams(email: event.email, password: event.password,user: event.user));
    result.fold(
      (failure) => emit(SignUpFailed(failure.message)),
      (user) => emit(SignUpSuccess()),
    );
  }

  Future<void> _onSignOut(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(SignOutLoading());
    final result = await SignOut(sl<AuthRepository>()).call(NoParams());
    result.fold(
      (failure) => emit(SignOutFailed(failure.message)),
      (_) => emit(SignOutSuccess()),
    );
  }

  Future<void> _onGetCurrentUser(
    GetCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(GetCurrentUserLoading());
    final result = await GetCurrentUser(sl<AuthRepository>()).call(false);
    result.fold(
          (failure) => emit(GetCurrentUserFailed(failure.message)),
          (user) => user != null
          ? emit(GetCurrentUserLoaded())
          : emit(Unauthenticated()),
    );
  }


  Future<void> _onResetPassword(
      ResetPassword event,
      Emitter<AuthState> emit,
      ) async {
    emit(SendResetPasswordEmailLoading());
    final result = await ResetPasswordUseCase(sl<AuthRepository>()).call(event.email);
    // Suggested
    result.fold(
          (failure) => emit(SendResetPasswordEmailFailed(failure.message)),
          (_)=>emit(SendResetPasswordEmailSuccess()),
    );
  }
}
