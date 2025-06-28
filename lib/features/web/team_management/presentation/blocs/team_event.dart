part of 'team_bloc.dart';
abstract class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object> get props => [];
}

class LoadTeams extends TeamEvent {}
// Add other team-related events here (e.g., AddTeam, UpdateTeam, DeleteTeam)

