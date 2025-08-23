import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/entities/match_event_entity.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/repositories/match_event_repository.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/usecases/get_match_events_usecase.dart';

class DeleteMatchEventsUseCase implements UseCase<void, MatchEventsParams> {
  final MatchEventRepository matchEventRepository;

  DeleteMatchEventsUseCase(this.matchEventRepository);

  @override
  Future<Either<AppException,void>> call(MatchEventsParams params) async {
    return await matchEventRepository.deleteMatchEvent(params.matchId??'',params.matchEventId??'');
  }
}