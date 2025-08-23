import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/entities/match_event_entity.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/repositories/match_event_repository.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/usecases/add_match_event_usecase.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/usecases/delete_match_event_usecase.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/usecases/get_match_events_usecase.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/usecases/update_match_event_usecase.dart';
import 'package:sport_app_user/injection_container.dart';

part 'match_event_event.dart';
part 'match_event_state.dart';

class MatchEventBloc extends Bloc<MatchEventEvent, MatchEventState> {

  MatchEventBloc() : super(MatchEventInitial()) {
    on<LoadMatchEvents>(_onLoadMatchEvents);
    on<AddMatchEvent>(_onAddMatchEvent);
  }

  Future<void> _onLoadMatchEvents(LoadMatchEvents event, Emitter<MatchEventState> emit) async {
    emit(MatchEventLoading());
    final useCase = await GetMatchEventsUseCase(sl<MatchEventRepository>()).call(event.matchId);
    useCase.fold((failure)=>emit(const MatchEventError('Failed to load match events')),
        (matchEvents)=>emit(MatchEventLoaded(matchEvents)));

  }

  Future<void> _onAddMatchEvent(AddMatchEvent event, Emitter<MatchEventState> emit) async {
    emit(AddMatchEventLoading());
    final useCase = await AddMatchEventsUseCase(sl<MatchEventRepository>()).call(event.matchEventEntity);
    useCase.fold((failure)=>emit(const AddMatchEventFailed('Failed to Add match events')),
            (_)=>emit(AddMatchEventSuccess()));
  }

  Future<void> _onEditMatchEvent(EditMatchEvent event, Emitter<MatchEventState> emit) async {
    emit(EditMatchEventLoading());
    final useCase = await UpdateMatchEventsUseCase(sl<MatchEventRepository>()).call(event.matchEventEntity);
    useCase.fold((failure)=>emit(const EditMatchEventFailed('Failed to Edit match events')),
            (_)=>emit(EditMatchEventSuccess()));
  }

  Future<void> _onDeleteMatchEvent(DeleteMatchEvent event, Emitter<MatchEventState> emit) async {
    emit(EditMatchEventLoading());
    final useCase = await DeleteMatchEventsUseCase(sl<MatchEventRepository>()).call(event.matchEventsParams);
    useCase.fold((failure)=>emit(const EditMatchEventFailed('Failed to Edit match events')),
            (_)=>emit(EditMatchEventSuccess()));
  }
}

