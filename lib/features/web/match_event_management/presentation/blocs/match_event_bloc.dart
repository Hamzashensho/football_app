import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/entities/match_event_entity.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/usecases/get_match_events_usecase.dart';

part 'match_event_event.dart';
part 'match_event_state.dart';

class MatchEventBloc extends Bloc<MatchEventEvent, MatchEventState> {
  final GetMatchEventsUseCase getMatchEventsUseCase;

  MatchEventBloc({required this.getMatchEventsUseCase}) : super(MatchEventInitial()) {
    on<LoadMatchEvents>(_onLoadMatchEvents);
    // Register other event handlers here
  }

  Future<void> _onLoadMatchEvents(LoadMatchEvents event, Emitter<MatchEventState> emit) async {
    emit(MatchEventLoading());
    final usecase = await getMatchEventsUseCase.call(MatchEventsParams(matchId: event.matchId));
    usecase.fold((failure)=>emit(const MatchEventError('Failed to load match events')),
        (matchEvents)=>emit(MatchEventLoaded(matchEvents)));

  }
}

