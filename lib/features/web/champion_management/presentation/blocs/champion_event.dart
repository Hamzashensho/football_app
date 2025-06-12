part of 'champion_bloc.dart';
abstract class ChampionEvent extends Equatable {
  const ChampionEvent();

  @override
  List<Object> get props => [];
}

class LoadChampions extends ChampionEvent {}

