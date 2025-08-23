import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/mobile/account/data/model/user_model.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/mobile/profile/data/datasources/profile_reomte_datasource.dart';
import 'package:sport_app_user/features/mobile/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<AppException, UserEntity>> getUser(
      String userId
      ) async {
    try {
      final userEntity = await remoteDataSource.getUserData(userId);
      return Right(userEntity);
    }  catch (e, st) {
      return Left(Failure(
        message: 'Failed to get user data',
        stackTrace: st,
        code: 'get-user-failed',
      ));
    }
  }



  @override
  Future<Either<AppException, void>> editUser(
      UserEntity userEntity
      ) async {
    try {
      final userModel = UserModel(
        userId: userEntity.uid ?? '',
        firstName: userEntity.firstName,
        lastName: userEntity.lastName,
        dob: userEntity.dob ?? DateTime.now(),
        phoneNumber: userEntity.phoneNumber ?? '',
        email: userEntity.email,
        country: userEntity.country ?? '',
        stateProvince: userEntity.stateProvince ?? '',
        municipality: userEntity.municipality ?? '',
        zipCode: userEntity.zipCode ?? '',
        favoriteTeamId: userEntity.favoriteTeamId ?? '',
        notifications: userEntity.notifications ?? UserNotifications(app: true, favoriteTeam: true),
        pictureUrl: userEntity.pictureUrl ?? '',
        fcmToken: userEntity.fcmToken ?? '',
      );
       await remoteDataSource.editUserData(
        userModel
      );
      return const Right(null);
    } on AppException catch (e) {
      return Left(e);
    } catch (e, st) {
      return Left(
        AuthException(
          message: 'Failed to edit user:$e',
          stackTrace: st,
          code: 'edit-user-failed',
        ),
      );
    }
  }


}
