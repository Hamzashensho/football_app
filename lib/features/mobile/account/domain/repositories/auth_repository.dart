import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';

import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<AppException, UserEntity>> signInWithEmail(String email, String password);
  Future<Either<AppException,UserEntity>> signUpWithEmail(String email, String password,UserEntity userEntity);
  Future<Either<AppException,UserEntity>> signInWithGoogle();
  Future<Either<AppException,UserEntity>> signInWithFacebook();
  Future<Either<AppException, void>> signOut();
  Future<Either<AppException, UserEntity?>> getCurrentUser({bool isFromSplash=false});

  Future<Either<AppException, void>> resetEmailPassword(String email);

}
