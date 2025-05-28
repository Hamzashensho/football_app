import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/utils/logger.dart';
import 'package:sport_app_user/features/mobile/account/data/datasources/auth_local_data_source.dart';
import 'package:sport_app_user/features/mobile/account/data/datasources/auth_remote_data_source.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/mobile/account/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<AppException, UserEntity>> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final userModel = await remoteDataSource.signInWithEmail(email, password);
      await localDataSource.cacheUser(userModel);
      return Right(userModel.toEntity());
    } on AppException catch (e) {
      AppLogger.error(e.message);
      return Left(e);
    } catch (e, st) {
      return Left(
        AuthException(
          message: 'Failed to sign in with email',
          stackTrace: st,
          code: 'email-signin-failed',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, UserEntity>> signUpWithEmail(
    String email,
    String password,
    UserEntity user,
  ) async {
    try {
      final userModel = await remoteDataSource.signUpWithEmail(
        email,
        password,
        user,
      );
      await localDataSource.cacheUser(userModel);
      return Right(userModel.toEntity());
    } on AppException catch (e) {
      AppLogger.error(e.message);
      return Left(e);
    } catch (e, st) {
      AppLogger.error(e.toString());
      return Left(
        AuthException(
          message: 'Failed to sign up with email:$e',
          stackTrace: st,
          code: 'email-signup-failed',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, UserEntity>> signInWithGoogle() async {
    try {
      final userModel = await remoteDataSource.signInWithGoogle();
      await localDataSource.cacheUser(userModel);
      return Right(userModel.toEntity());
    } on AppException catch (e) {
      AppLogger.error(e.message);
      return Left(e);
    } catch (e, st) {
      AppLogger.error(e.toString());
      return Left(
        AuthException(
          message: 'Failed to sign in with Google',
          stackTrace: st,
          code: 'google-signing-failed',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, UserEntity>> signInWithFacebook() async {
    try {
      final userModel = await remoteDataSource.signInWithFacebook();
      await localDataSource.cacheUser(userModel);
      return Right(userModel.toEntity());
    } on AppException catch (e) {
      AppLogger.error(e.message);
      return Left(e);
    } catch (e, st) {
      return Left(
        AuthException(
          message: 'Failed to sign in with Facebook',
          stackTrace: st,
          code: 'facebook-signin-failed',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      await localDataSource.clearCache();
      return const Right(null);
    } on AppException catch (e) {
      AppLogger.error(e.message);
      return Left(e);
    } catch (e, st) {
      return Left(
        AuthException(
          message: 'Failed to sign out',
          stackTrace: st,
          code: 'signout-failed',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, UserEntity?>> getCurrentUser({
    bool isFromSplash = false,
  }) async {
    try {
      if (!isFromSplash) {
        final cached = await localDataSource.getCachedUser();
        if (cached != null) return Right(cached.toEntity());
      }

      final remoteUser = await remoteDataSource.getCurrentUser();
      if (remoteUser != null) {
        await localDataSource.cacheUser(remoteUser);
      }

      return Right(remoteUser?.toEntity());
    } on AppException catch (e) {
      AppLogger.error(e.message);
      return Left(e);
    } catch (e, st) {
      return Left(
        CacheException(
          message: 'Failed to get current user',
          stackTrace: st,
          code: 'get-user-failed',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, void>> resetEmailPassword(String email) async {
    try {
      await remoteDataSource.resetEmailPassword(email);
      return const Right(null);
    } on AppException catch (e) {
      AppLogger.error(e.message);
      return Left(e);
    } catch (e, st) {
      return Left(
        AuthException(
          message: 'Failed to send password email reset',
          stackTrace: st,
          code: 'reset-password-failed',
        ),
      );
    }
  }
}
