part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class LoadPlayers extends PlayerEvent {}

class AddPlayer extends PlayerEvent {
  final PlayerEntity playerEntity;

  const AddPlayer({required this.playerEntity});

  @override
  List<Object> get props => [playerEntity];
}

class EditPlayer extends PlayerEvent {
  final PlayerEntity playerEntity;

  const EditPlayer({required this.playerEntity});

  @override
  List<Object> get props => [playerEntity];
}

class DeletePlayer extends PlayerEvent {
  final String playerId;

  const DeletePlayer({required this.playerId});

  @override
  List<Object> get props => [playerId];
}
