import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/entities/match_event_entity.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/repositories/match_event_repository.dart';

class GetMatchEventsUseCase implements UseCase<List<MatchEventEntity>, String> {
  final MatchEventRepository matchEventRepository;

  GetMatchEventsUseCase(this.matchEventRepository);

  @override
  Future<Either<AppException,List<MatchEventEntity>>> call(String matchId) async {
    return await matchEventRepository.getMatchEvents(matchId);
  }
}

class MatchEventsParams extends Equatable {
  final String? matchId;
  final String? matchEventId;

  const MatchEventsParams({ this.matchId,this.matchEventId});

  @override
  List<Object?> get props => [matchId,matchEventId];
}

