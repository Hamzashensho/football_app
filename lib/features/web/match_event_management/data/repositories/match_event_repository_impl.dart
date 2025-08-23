import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/match_event_management/data/datasources/remote/mock_match_event_datasource.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/entities/match_event_entity.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/repositories/match_event_repository.dart';

class MatchEventRepositoryImpl implements MatchEventRepository {
  final RemoteMatchEventDataSource remoteDataSource;

  MatchEventRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppException, List<MatchEventEntity>>> getMatchEvents(String matchId) async {
    try {
      final List<MatchEventEntity> matchEvents = await remoteDataSource.getMatchEvents(matchId);
      return Right(matchEvents);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'get-match-events-failed',
      ));
    }
  }

  @override
  Future<Either<AppException, void>> addMatchEvent(MatchEventEntity event) async {
    try {
      await remoteDataSource.addMatchEvent(event);
      return const Right(null);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'add-match-event-failed',
      ));
    }
  }

  @override
  Future<Either<AppException, void>> updateMatchEvent(MatchEventEntity event) async {
    try {
      await remoteDataSource.updateMatchEvent(event);
      return const Right(null);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'update-match-event-failed',
      ));
    }
  }

  @override
  Future<Either<AppException, void>> deleteMatchEvent(String matchId, String matchEventId) async {
    try {
      await remoteDataSource.deleteMatchEvent(matchId, matchEventId);
      return const Right(null);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'delete-match-event-failed',
      ));
    }
  }
}
