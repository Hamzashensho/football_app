import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/entities/match_event_entity.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/repositories/match_event_repository.dart';

class UpdateMatchEventsUseCase implements UseCase<void, MatchEventEntity> {
  final MatchEventRepository matchEventRepository;

  UpdateMatchEventsUseCase(this.matchEventRepository);

  @override
  Future<Either<AppException,void>> call(MatchEventEntity params) async {
    return await matchEventRepository.updateMatchEvent(params);
  }
}