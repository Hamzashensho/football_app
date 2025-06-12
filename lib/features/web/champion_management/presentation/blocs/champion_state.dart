part of 'champion_bloc.dart';

@immutable
sealed class ChampionState extends Equatable {
  const ChampionState();

  @override
  List<Object> get props => [];
}

class ChampionInitial extends ChampionState {}

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

