import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/player_management/domain/entities/player_entity.dart';
import 'package:sport_app_user/features/web/player_management/domain/usecases/get_players_usecase.dart';

part 'player_event.dart';
part 'player_state.dart';
class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final GetPlayersUseCase getPlayersUseCase;

  PlayerBloc({required this.getPlayersUseCase}) : super(PlayerInitial()) {
    on<LoadPlayers>(_onLoadPlayers);
    // Register other event handlers here
  }

  Future<void> _onLoadPlayers(LoadPlayers event, Emitter<PlayerState> emit) async {
    emit(PlayerLoading());
    final players = await getPlayersUseCase.call(NoParams());

    players.fold((failure)=> emit(PlayerError('Failed to load players: ${failure.message}')),
        (players)=>emit(PlayerLoaded(players)));

  }
}

