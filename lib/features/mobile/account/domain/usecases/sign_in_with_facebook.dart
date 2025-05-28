import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/mobile/account/domain/repositories/auth_repository.dart';

class SignInWithFacebook implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  SignInWithFacebook(this.repository);

  @override
  Future<Either<AppException,UserEntity>> call(NoParams params) {
    return repository.signInWithFacebook();
  }
}
