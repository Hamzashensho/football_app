import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/mobile/account/domain/repositories/auth_repository.dart';
import 'package:sport_app_user/features/mobile/profile/domain/repositories/profile_repository.dart';

class GetUserProfileUseCase implements UseCase<UserEntity, String> {
  final ProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<Either<AppException,UserEntity>> call(String params) {
    return repository.getUser(params);
  }
}

