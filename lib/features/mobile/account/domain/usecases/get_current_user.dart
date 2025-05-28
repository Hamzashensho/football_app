import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/mobile/account/domain/repositories/auth_repository.dart';

class GetCurrentUser implements UseCase<UserEntity, bool> {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<AppException,UserEntity?>> call(bool isFromSplash) async {
    final user = await repository.getCurrentUser(isFromSplash: isFromSplash);
    return user;
  }
}
