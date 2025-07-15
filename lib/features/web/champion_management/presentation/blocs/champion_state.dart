part of 'champion_bloc.dart';

@immutable
sealed class ChampionState extends Equatable {
  const ChampionState();

  @override
  List<Object> get props => [];
}

class ChampionInitial extends ChampionState {}

//load champions states
class ChampionLoading extends ChampionState {}

class ChampionLoaded extends ChampionState {
  final List<ChampionEntity> champions;

  const ChampionLoaded({required this.champions});

  @override
  List<Object> get props => [champions];
}

class ChampionError extends ChampionState {
  final String message;

  const ChampionError(this.message);

  @override
  List<Object> get props => [message];
}

//Add champion states
class AddChampionLoading extends ChampionState{}
class AddChampionSuccess extends ChampionState{}
class AddChampionError extends ChampionState {
  final String message;

  const AddChampionError(this.message);

  @override
  List<Object> get props => [message];
}

//Delete Champion States
class DeleteChampionLoading extends ChampionState{}
class DeleteChampionSuccess extends ChampionState{}
class DeleteChampionError extends ChampionState {
  final String message;

  const DeleteChampionError(this.message);

  @override
  List<Object> get props => [message];
}

//Edit champions states
class EditChampionLoading extends ChampionState{}
class EditChampionSuccess extends ChampionState{
  final ChampionEntity championEntity;
  const EditChampionSuccess({required this.championEntity});
}
class EditChampionError extends ChampionState {
  final String message;

  const EditChampionError(this.message);

  @override
  List<Object> get props => [message];
}
