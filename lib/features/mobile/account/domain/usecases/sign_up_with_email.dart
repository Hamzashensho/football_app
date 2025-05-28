import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/mobile/account/domain/repositories/auth_repository.dart';
import 'package:sport_app_user/features/mobile/account/domain/usecases/sign_in_with_email.dart';

class SignUpWithEmail implements UseCase<UserEntity,SignInWithEmailParams> {
  final AuthRepository repository;

  SignUpWithEmail(this.repository);

  @override
  Future<Either<AppException,UserEntity>> call(SignInWithEmailParams params) {
    return repository.signUpWithEmail(params.email, params.password,params.user!);
  }
}
