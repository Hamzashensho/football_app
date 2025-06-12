import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';
import 'package:sport_app_user/features/web/match_management/domain/usecases/get_matches_usecase.dart';

part 'match_event.dart';
part 'match_state.dart';
class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final GetMatchesUseCase getMatchesUseCase;

  MatchBloc({required this.getMatchesUseCase}) : super(MatchInitial()) {
    on<LoadMatches>(_onLoadMatches);
    // Register other event handlers here
  }

  Future<void> _onLoadMatches(LoadMatches event, Emitter<MatchState> emit) async {
    emit(MatchLoading());
    final usecase = await getMatchesUseCase.call(NoParams());
    usecase.fold((failure)=> emit(const MatchError('Failed to load matches')),
        (matches)=>emit(MatchLoaded(matches)));


  }
}

