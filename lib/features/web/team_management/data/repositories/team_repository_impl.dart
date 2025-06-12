import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';
import 'package:sport_app_user/features/web/team_management/domain/repositories/team_repository.dart';
import 'package:sport_app_user/features/web/team_management/data/datasources/remote/mock_team_datasource.dart';

class TeamRepositoryImpl implements TeamRepository {
  final MockTeamDataSource mockTeamDataSource;

  TeamRepositoryImpl({required this.mockTeamDataSource});

  @override
  Future<Either<AppException,List<TeamEntity>>> getTeams() async {
    try {
      final List<TeamEntity> teams= await mockTeamDataSource.getTeams();
      return Right(teams);
    } on Exception catch (e,st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'get-teams-failed'
      ));
    }
  }
  
  // Implement other methods like addTeam, updateTeam, deleteTeam here
}

