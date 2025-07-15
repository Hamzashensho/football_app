import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';
import 'package:sport_app_user/features/web/team_management/domain/repositories/team_repository.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/add_team_usecase.dart';

class EditTeamUseCase implements UseCase<void, TeamParams> {
  final TeamRepository teamRepository;

  EditTeamUseCase(this.teamRepository);

  @override
  Future<Either<AppException, void>> call(TeamParams params) async {
    return await teamRepository.editTeam(
      TeamEntity(
        teamId: params.teamId??'',
        name: params.name ?? '',
        goalCount: params.goalCount,
      ),
    );
  }
}