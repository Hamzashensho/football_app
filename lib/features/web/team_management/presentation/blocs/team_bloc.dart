import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/get_teams_usecase.dart';

part 'team_event.dart';

part 'team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  final GetTeamsUseCase getTeamsUseCase;

  TeamBloc({required this.getTeamsUseCase}) : super(TeamInitial()) {
    on<LoadTeams>(_onLoadTeams);
    // Register other event handlers here
  }

  Future<void> _onLoadTeams(LoadTeams event, Emitter<TeamState> emit) async {
    emit(TeamLoading());
    final teams = await getTeamsUseCase.call(NoParams());
    teams.fold(
      (failure) => emit(const TeamError('Failed to load teams')),
      (teams) => emit(TeamLoaded(teams)),
    );

  }
}
