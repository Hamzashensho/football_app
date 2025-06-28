part of'team_bloc.dart';
abstract class TeamState extends Equatable {
  const TeamState();

  @override
  List<Object> get props => [];
}

class TeamInitial extends TeamState {}

class TeamLoading extends TeamState {}

class TeamLoaded extends TeamState {
  final List<TeamEntity> teams;

  const TeamLoaded(this.teams);

  @override
  List<Object> get props => [teams];
}

class TeamError extends TeamState {
  final String message;

  const TeamError(this.message);

  @override
  List<Object> get props => [message];
}

