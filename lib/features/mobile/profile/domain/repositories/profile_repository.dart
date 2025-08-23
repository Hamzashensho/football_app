import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';

import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<AppException, UserEntity>> getUser(String userId);
  Future<Either<AppException,void>> editUser(UserEntity userEntity);

}
