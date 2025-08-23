import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/mobile/profile/domain/repositories/profile_repository.dart';
import 'package:sport_app_user/features/mobile/profile/domain/usecases/edit_user_usecase.dart';
import 'package:sport_app_user/features/mobile/profile/domain/usecases/get_user_usecase.dart';
import 'package:sport_app_user/injection_container.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetUser>(_onGetUser);
    on<EditUser>(_onEditUser);
  }


  Future<void> _onGetUser(
      GetUser event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());
    final result = await GetUserProfileUseCase(
      sl<ProfileRepository>(),
    ).call(FirebaseAuth.instance.currentUser!.uid);
    result.fold(
      (failure) => emit(ProfileError(message:failure.message)),
      (user) => emit(ProfileSuccess(userEntity: user)),
    );
  }

  Future<void> _onEditUser(
      EditUser event,
      Emitter<ProfileState> emit,
      ) async {
    emit(EditProfileLoading());
    final result = await EditUserUseCase(
      sl<ProfileRepository>(),
    ).call(event.userEntity);
    result.fold(
          (failure) => emit(EditProfileError(message:failure.message)),
          (user) => emit(EditProfileSuccess(userEntity: event.userEntity)),
    );
  }




}
