import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';
import 'package:sport_app_user/features/web/team_management/domain/repositories/team_repository.dart';

class DeleteTeamUseCase implements UseCase<void, String> {
  final TeamRepository teamRepository;

  DeleteTeamUseCase(this.teamRepository);

  @override
  Future<Either<AppException, void>> call(String params) async {
    return await teamRepository.deleteTeam(
      params
    );
  }
}