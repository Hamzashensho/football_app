import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';
import 'package:sport_app_user/features/web/team_management/domain/repositories/team_repository.dart';

class AddTeamUseCase implements UseCase<void, TeamParams> {
  final TeamRepository teamRepository;

  AddTeamUseCase(this.teamRepository);

  @override
  Future<Either<AppException, void>> call(TeamParams params) async {
    return await teamRepository.addTeam(
      TeamEntity(
        teamId: '',
        name: params.name ?? '',
        goalCount: params.goalCount,
      ),
    );
  }
}

class TeamParams {
  final String? teamId;
  final String? name;
  final int? goalCount;

  TeamParams({this.teamId, this.name, this.goalCount});
}
