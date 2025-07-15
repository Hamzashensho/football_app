part of 'team_bloc.dart';

@immutable
sealed class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object> get props => [];
}

class LoadTeams extends TeamEvent {}

class AddTeam extends TeamEvent{
  final TeamParams teamParams;

  const AddTeam({required this.teamParams});
}

class EditTeam extends TeamEvent{
  final TeamParams teamParams;
  const EditTeam({required this.teamParams});
}

class DeleteTeam extends TeamEvent{
  final String teamId;
  const DeleteTeam({required this.teamId});
}

