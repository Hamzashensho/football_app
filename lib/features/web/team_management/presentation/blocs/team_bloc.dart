import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';
import 'package:sport_app_user/features/web/team_management/domain/repositories/team_repository.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/add_team_usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/delete_team_usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/edit_team_usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/get_teams_usecase.dart';
import 'package:sport_app_user/injection_container.dart';

part 'team_event.dart';

part 'team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {

  TeamBloc() : super(TeamInitial()) {
    on<LoadTeams>(_onLoadTeams);
    on<AddTeam>(_onAddTeam);
    on<EditTeam>(_onEditTeam);
    on<DeleteTeam>(_onDeleteTeam);
  }

  List<TeamEntity> teamsList=[];

  Future<void> _onLoadTeams(LoadTeams event, Emitter<TeamState> emit) async {
    emit(TeamLoading());
    final teams = await GetTeamsUseCase(sl<TeamRepository>()).call(NoParams());
    teams.fold(
      (failure) => emit(const TeamError('Failed to load teams')),
      (teams) {
        teamsList=teams;
        emit(TeamLoaded(teams));
      }
    );
  }

  Future<void> _onAddTeam(AddTeam event, Emitter<TeamState> emit) async {
    emit(AddTeamLoading());
    final res = await AddTeamUseCase(sl<TeamRepository>()).call(event.teamParams);
    res.fold(
          (failure) => emit(const AddTeamFailed('Failed to add team')),
          (_) => emit(AddTeamSuccess()),
    );
  }

  Future<void> _onEditTeam(EditTeam event, Emitter<TeamState> emit) async {
    emit(EditTeamLoading());
    final res = await EditTeamUseCase(sl<TeamRepository>()).call(event.teamParams);
    res.fold(
          (failure) => emit(const EditTeamFailed('Failed to add team')),
          (_) => emit(EditTeamSuccess()),
    );
  }

  Future<void> _onDeleteTeam(DeleteTeam event, Emitter<TeamState> emit) async {
    emit(DeleteTeamLoading());
    final res = await DeleteTeamUseCase(sl<TeamRepository>()).call(event.teamId);
    res.fold(
          (failure) => emit(const DeleteTeamFailed('Failed to add team')),
          (_) => emit(DeleteTeamSuccess()),
    );
  }

}
