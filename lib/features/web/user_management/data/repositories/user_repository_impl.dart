import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/user_management/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/web/user_management/domain/repositories/user_repository.dart';
import 'package:sport_app_user/features/web/user_management/data/datasources/remote/mock_user_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final MockUserDataSource mockUserDataSource;

  UserRepositoryImpl({required this.mockUserDataSource});

  @override
  Future<Either<AppException,List<UserEntity>>> getUsers() async {
    try {
      final List<UserEntity> users=await mockUserDataSource.getUsers();
      return Right(users);
    } on Exception catch (e,st) {
      return Left(
        Failure(
          message: e.toString(),
          stackTrace: st,
          code: 'get-users-failed')
      );
    }
  }
  
  // Implement other methods like addUser, updateUser, deleteUser here
  // For example:
  // Future<void> addUser(UserEntity user) async {
  //   // Call mockUserDataSource.addUser(user) or similar
  // }
}
