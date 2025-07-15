import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';
import 'package:sport_app_user/features/web/match_management/domain/repositories/match_repository.dart';
import 'package:sport_app_user/features/web/match_management/domain/usecases/add_match_usecase.dart';
import 'package:sport_app_user/features/web/match_management/domain/usecases/delete_match_usecase.dart';
import 'package:sport_app_user/features/web/match_management/domain/usecases/edit_match_usecase.dart';
import 'package:sport_app_user/features/web/match_management/domain/usecases/get_matches_usecase.dart';
import 'package:sport_app_user/injection_container.dart';

part 'match_event.dart';

part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  MatchBloc() : super(MatchInitial()) {
    on<LoadMatches>(_onLoadMatches);
    on<AddMatch>(_onAddMatch);
    on<EditMatch>(_onEditMatch);
    on<DeleteMatch>(_onDeleteMatch);
  }

  Future<void> _onLoadMatches(
    LoadMatches event,
    Emitter<MatchState> emit,
  ) async {
    emit(MatchLoading());
    final useCase = await GetMatchesUseCase(
      sl<MatchRepository>(),
    ).call(NoParams());
    useCase.fold(
      (failure) => emit(MatchError(failure.message)),
      (matches) => emit(MatchLoaded(matches)),
    );
  }

  Future<void> _onAddMatch(AddMatch event, Emitter<MatchState> emit) async {
    emit(AddMatchLoading());
    final useCase = await AddMatchUseCase(
      sl<MatchRepository>(),
    ).call(event.matchEntity);
    useCase.fold(
      (failure) => emit(AddMatchFailed(message: failure.message)),
      (matches) => emit(AddMatchSuccess()),
    );
  }

  Future<void> _onEditMatch(EditMatch event, Emitter<MatchState> emit) async {
    emit(EditMatchLoading());
    final useCase = await EditMatchUseCase(
      sl<MatchRepository>(),
    ).call(event.matchEntity);
    useCase.fold(
      (failure) => emit(EditMatchFailed(message: failure.message)),
      (matches) => emit(EditMatchSuccess()),
    );
  }

  Future<void> _onDeleteMatch(
    DeleteMatch event,
    Emitter<MatchState> emit,
  ) async {
    emit(DeleteMatchLoading());
    final useCase = await DeleteMatchUseCase(
      sl<MatchRepository>(),
    ).call(event.matchId);
    useCase.fold(
      (failure) => emit(DeleteMatchFailed(message: failure.message)),
      (matches) => emit(DeleteMatchSuccess()),
    );
  }
}
