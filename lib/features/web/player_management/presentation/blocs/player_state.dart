part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class PlayerInitial extends PlayerState {}

class PlayerLoading extends PlayerState {}

class PlayerLoaded extends PlayerState {
  final List<PlayerEntity> players;

  const PlayerLoaded(this.players);

  @override
  List<Object> get props => [players];
}

class PlayerError extends PlayerState {
  final String message;

  const PlayerError(this.message);

  @override
  List<Object> get props => [message];
}

//AddPlayer states
class AddPlayerLoading extends PlayerState{}
class AddPlayerSuccess extends PlayerState{}
class AddPlayerFailed extends PlayerState{
  final String message;
  const AddPlayerFailed({required this.message});

  @override
  List<Object> get props => [message];
}

//EditPlayer states
class EditPlayerLoading extends PlayerState{}
class EditPlayerSuccess extends PlayerState{}
class EditPlayerFailed extends PlayerState{
  final String message;
  const EditPlayerFailed({required this.message});

  @override
  List<Object> get props => [message];
}

//DeletePlayer states
class DeletePlayerLoading extends PlayerState{}
class DeletePlayerSuccess extends PlayerState{}
class DeletePlayerFailed extends PlayerState{
  final String message;
  const DeletePlayerFailed({required this.message});

  @override
  List<Object> get props => [message];
}