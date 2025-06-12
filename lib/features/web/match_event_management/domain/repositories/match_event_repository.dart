import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/entities/match_event_entity.dart';

abstract class MatchEventRepository {
  Future<Either<AppException,List<MatchEventEntity>>> getMatchEvents(String matchId);
}

