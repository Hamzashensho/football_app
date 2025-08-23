import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/mobile/account/domain/repositories/auth_repository.dart';
import 'package:sport_app_user/features/mobile/profile/domain/repositories/profile_repository.dart';

class EditUserUseCase implements UseCase<void, UserEntity> {
  final ProfileRepository repository;

  EditUserUseCase(this.repository);

  @override
  Future<Either<AppException,void>> call(UserEntity params) {
    return repository.editUser(params);
  }
}

