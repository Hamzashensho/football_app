import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/player_management/domain/entities/player_entity.dart';
import 'package:sport_app_user/features/web/player_management/domain/repositories/player_repository.dart';
import 'package:sport_app_user/features/web/player_management/domain/usecases/add_player_usecase.dart';
import 'package:sport_app_user/features/web/player_management/domain/usecases/delete_player_usecase.dart';
import 'package:sport_app_user/features/web/player_management/domain/usecases/edit_player_usecase.dart';
import 'package:sport_app_user/features/web/player_management/domain/usecases/get_players_usecase.dart';
import 'package:sport_app_user/injection_container.dart';

part 'player_event.dart';

part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(PlayerInitial()) {
    on<LoadPlayers>(_onLoadPlayers);
    on<AddPlayer>(_onAddPlayer);
    on<EditPlayer>(_onEditPlayer);
    on<DeletePlayer>(_onDeletePlayer);
  }

  List<PlayerEntity> playersList = [];

  Future<void> _onLoadPlayers(
    LoadPlayers event,
    Emitter<PlayerState> emit,
  ) async {
    emit(PlayerLoading());
    final players = await GetPlayersUseCase(
      sl<PlayerRepository>(),
    ).call(NoParams());

    players.fold(
      (failure) =>
          emit(PlayerError('Failed to load players: ${failure.message}')),
      (players) {
        playersList = players;
        emit(PlayerLoaded(players));
      },
    );
  }

  Future<void> _onAddPlayer(AddPlayer event, Emitter<PlayerState> emit) async {
    emit(AddPlayerLoading());
    final useCase = await AddPlayerUseCase(
      sl<PlayerRepository>(),
    ).call(event.playerEntity);
    useCase.fold(
          (failure) => emit(AddPlayerFailed(message: failure.message)),
          (players) => emit(AddPlayerSuccess()),
    );
  }

  Future<void> _onEditPlayer(EditPlayer event, Emitter<PlayerState> emit) async {
    emit(EditPlayerLoading());
    final useCase = await EditPlayerUseCase(
      sl<PlayerRepository>(),
    ).call(event.playerEntity);
    useCase.fold(
          (failure) => emit(EditPlayerFailed(message: failure.message)),
          (player) => emit(EditPlayerSuccess()),
    );
  }

  Future<void> _onDeletePlayer(
      DeletePlayer event,
      Emitter<PlayerState> emit,
      ) async {
    emit(DeletePlayerLoading());
    final useCase = await DeletePlayerUseCase(
      sl<PlayerRepository>(),
    ).call(event.playerId);
    useCase.fold(
          (failure) => emit(DeletePlayerFailed(message: failure.message)),
          (player) => emit(DeletePlayerSuccess()),
    );
  }
}
