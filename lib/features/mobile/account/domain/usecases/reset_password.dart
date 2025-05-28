import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/mobile/account/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase extends UseCase<void, String> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<AppException,void>> call(String email) {
    return repository.resetEmailPassword(email);
  }
}
