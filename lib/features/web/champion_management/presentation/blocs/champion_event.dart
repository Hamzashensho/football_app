part of 'champion_bloc.dart';

@immutable
sealed class ChampionEvent extends Equatable {
  const ChampionEvent();

  @override
  List<Object> get props => [];
}

class LoadChampions extends ChampionEvent {}

class AddChampion extends ChampionEvent {
  final DateTime date;
  final String title;

  const AddChampion({required this.date, required this.title});

  @override
  List<Object> get props => [date, title];
}

class DeleteChampion extends ChampionEvent {
  final String championId;

  const DeleteChampion({required this.championId});

  @override
  List<Object> get props => [championId];
}

class EditChampion extends ChampionEvent {
  final String championId;
  final DateTime date;
  final String title;

  const EditChampion({required this.championId,required this.date, required this.title});

  @override
  List<Object> get props => [championId,date, title];
}