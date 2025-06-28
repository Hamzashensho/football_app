import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';
import 'package:sport_app_user/features/web/team_management/domain/repositories/team_repository.dart';


class GetTeamsUseCase implements UseCase<List<TeamEntity>, NoParams> {
  final TeamRepository teamRepository;

  GetTeamsUseCase(this.teamRepository);

  @override
  Future<Either<AppException,List<TeamEntity>>> call(NoParams params) async {
    return await teamRepository.getTeams();
  }
}

