part of 'player_bloc.dart';
abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class LoadPlayers extends PlayerEvent {}
// Add other player-related events here

