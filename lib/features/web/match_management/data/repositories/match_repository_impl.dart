import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';
import 'package:sport_app_user/features/web/match_management/domain/repositories/match_repository.dart';
import 'package:sport_app_user/features/web/match_management/data/datasources/remote/remote_match_datasource.dart';

class MatchRepositoryImpl implements MatchRepository {
  final RemoteMatchDataSource remoteMatchDataSource;

  MatchRepositoryImpl({required this.remoteMatchDataSource});

  @override
  Future<Either<AppException, List<MatchEntity>>> getMatches() async {
    try {
      final matches = await remoteMatchDataSource.getMatches();
      return Right(matches);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'get-matches-failed',
      ));
    }
  }

  @override
  Future<Either<AppException, void>> addMatch(MatchEntity match) async {
    try {
      await remoteMatchDataSource.addMatch(match);
      return const Right(null);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'add-match-failed',
      ));
    }
  }

  @override
  Future<Either<AppException, MatchEntity>> getMatchById(String id) async {
    try {
      final match = await remoteMatchDataSource.getMatchById(id);
      return Right(match);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'get-match-by-id-failed',
      ));
    }
  }

  @override
  Future<Either<AppException, void>> deleteMatch(String id) async {
    try {
      await remoteMatchDataSource.deleteMatch(id);
      return const Right(null);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'delete-match-failed',
      ));
    }
  }

  @override
  Future<Either<AppException, void>> editMatch(MatchEntity match) async {
    try {
      await remoteMatchDataSource.editMatch(match);
      return const Right(null);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'edit-match-failed',
      ));
    }
  }
}


