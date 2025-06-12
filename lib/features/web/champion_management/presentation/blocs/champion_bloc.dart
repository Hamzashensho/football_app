import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/entities/champion_entity.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/get_champions_usecase.dart';

part 'champion_event.dart';

part 'champion_state.dart';

class ChampionBloc extends Bloc<ChampionEvent, ChampionState> {
  final GetChampionsUseCase getChampionsUseCase;

  ChampionBloc({required this.getChampionsUseCase}) : super(ChampionInitial()) {
    on<LoadChampions>(_onLoadChampions);
    // Register other event handlers here
  }

  Future<void> _onLoadChampions(LoadChampions event,
      Emitter<ChampionState> emit) async {
    emit(ChampionLoading());
    final champions = await getChampionsUseCase.call(NoParams());
    champions.fold((failure) =>
        emit(const ChampionError('Failed to load champions:')),
        (champions)=>emit(ChampionLoaded(champions: champions??[])),
    );

  }
}

