import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import "package:sport_app_user/features/web/user_management/domain/entities/user_entity.dart";

abstract class UserRepository {
  Future<Either<AppException,List<UserEntity>>> getUsers();
  // Define other methods like addUser, updateUser, deleteUser as needed
}
