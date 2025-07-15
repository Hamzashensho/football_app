import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/core/utils/logger.dart';
import 'package:sport_app_user/features/web/champion_management/domain/entities/champion_entity.dart';
import 'package:sport_app_user/features/web/champion_management/domain/repositories/champion_repository.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/add_champion_usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/delete_champion_usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/edit_champion_usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/get_champions_usecase.dart';
import 'package:sport_app_user/injection_container.dart';

part 'champion_event.dart';

part 'champion_state.dart';

class ChampionBloc extends Bloc<ChampionEvent, ChampionState> {
  ChampionBloc() : super(ChampionInitial()) {
    on<LoadChampions>(_onLoadChampions);
    on<AddChampion>(_onAddChampion);
    on<DeleteChampion>(_onDeleteChampion);
    on<EditChampion>(_onEditChampion);
  }

  List<ChampionEntity> championsList=[];

  Future<void> _onLoadChampions(
    LoadChampions event,
    Emitter<ChampionState> emit,
  ) async {
    emit(ChampionLoading());
    final champions = await GetChampionsUseCase(
      sl<ChampionRepository>(),
    ).call(NoParams());
    champions.fold(
      (failure) =>
          emit(ChampionError('Failed to load champions:${failure.message}')),
      (champions) {
        championsList=champions??[];
        return emit(ChampionLoaded(champions: champions ?? []));
      },
    );
  }

  Future<void> _onAddChampion(
    AddChampion event,
    Emitter<ChampionState> emit,
  ) async {
    emit(AddChampionLoading());
    final champions = await AddChampionUseCase(
      sl<ChampionRepository>(),
    ).call(ChampionParams(date:event.date,title:  event.title));
    champions.fold(
      (failure) =>
          emit(AddChampionError('Failed to Add champions:${failure.message}')),
      (_) => emit(AddChampionSuccess()),
    );
  }

  Future<void> _onDeleteChampion(
    DeleteChampion event,
    Emitter<ChampionState> emit,
  ) async {
    emit(DeleteChampionLoading());
    final champions = await DeleteChampionUseCase(
      sl<ChampionRepository>(),
    ).call(event.championId);
    champions.fold(
      (failure) => emit(
        DeleteChampionError('Failed to Delete champion:${failure.message}'),
      ),
      (_) => emit(DeleteChampionSuccess()),
    );
  }

  Future<void> _onEditChampion(
      EditChampion event,
      Emitter<ChampionState> emit,
      ) async {
    emit(EditChampionLoading());
    final champion = await EditChampionUseCase(
      sl<ChampionRepository>(),
    ).call(ChampionParams(championId:event.championId,date:event.date,title:  event.title));
    champion.fold(
          (failure) =>
          emit(EditChampionError('Failed to Edit champions:${failure.message}')),
          (champ) => emit(EditChampionSuccess(championEntity: champ)),
    );
  }
}
