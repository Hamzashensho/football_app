import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/entities/match_event_entity.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/repositories/match_event_repository.dart';
import 'package:sport_app_user/features/web/match_event_management/data/datasources/remote/mock_match_event_datasource.dart';

class MatchEventRepositoryImpl implements MatchEventRepository {
  final MockMatchEventDataSource mockMatchEventDataSource;

  MatchEventRepositoryImpl({required this.mockMatchEventDataSource});

  @override
  Future<Either<AppException,List<MatchEventEntity>>> getMatchEvents(String matchId) async {
    try{
      final List<MatchEventEntity> matchEvents =await mockMatchEventDataSource.getMatchEvents(matchId);
      return Right(matchEvents);
    }catch (e,st){
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'get-match-events-failed',
      ));
    }
  }
  
  // Implement other methods like addMatchEvent, updateMatchEvent, deleteMatchEvent here
}

