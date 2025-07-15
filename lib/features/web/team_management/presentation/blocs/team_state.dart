part of'team_bloc.dart';
abstract class TeamState extends Equatable {
  const TeamState();

  @override
  List<Object> get props => [];
}

class TeamInitial extends TeamState {}

class TeamLoading extends TeamState {}

// LoadTeam states
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

//AddTeam states
class AddTeamLoading extends TeamState{}
class AddTeamSuccess extends TeamState{}
class AddTeamFailed extends TeamState{
  final String message;

  const AddTeamFailed(this.message);

  @override
  List<Object> get props => [message];
}

//EditTeam states
class EditTeamLoading extends TeamState{}
class EditTeamSuccess extends TeamState{}
class EditTeamFailed extends TeamState{
  final String message;

  const EditTeamFailed(this.message);

  @override
  List<Object> get props => [message];
}

//DeleteTeam states
class DeleteTeamLoading extends TeamState{}
class DeleteTeamSuccess extends TeamState{}
class DeleteTeamFailed extends TeamState{
  final String message;

  const DeleteTeamFailed(this.message);

  @override
  List<Object> get props => [message];
}