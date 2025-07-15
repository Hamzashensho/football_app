import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/team_management/data/model/team_model.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';
import 'package:sport_app_user/features/web/team_management/domain/repositories/team_repository.dart';
import 'package:sport_app_user/features/web/team_management/data/datasources/remote/team_remote_datasource.dart';

class TeamRepositoryImpl implements TeamRepository {
  final TeamRemoteDataSource mockTeamDataSource;

  TeamRepositoryImpl({required this.mockTeamDataSource});

  @override
  Future<Either<AppException,List<TeamEntity>>> getTeams() async {
    try {
      final List<TeamModel> teams= await mockTeamDataSource.getTeams();
      final List<TeamEntity> entityTeams=teams.map((team)=>team.toEntity()).toList();
      return Right(entityTeams);
    } on Exception catch (e,st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'get-teams-failed'
      ));
    }
  }

  @override
  Future<Either<AppException, void>> addTeam(TeamEntity teamEntity)async {
    try {
       await mockTeamDataSource.addTeam(TeamModel.fromEntity(teamEntity));
      return const Right(null);
    } on Exception catch (e,st) {
      return Left(Failure(
          message: e.toString(),
          stackTrace: st,
          code: 'add-team-failed'
      ));
    }
  }

  @override
  Future<Either<AppException, void>> deleteTeam(String teamId)async {
    try {
      await mockTeamDataSource.deleteTeam(teamId);
      return const Right(null);
    } on Exception catch (e,st) {
      return Left(Failure(
          message: e.toString(),
          stackTrace: st,
          code: 'delete-team-failed'
      ));
    }
  }

  @override
  Future<Either<AppException, void>> editTeam(TeamEntity teamEntity)async {
    try {
      await mockTeamDataSource.editTeam(TeamModel.fromEntity(teamEntity));
      return const Right(null);
    } on Exception catch (e,st) {
      return Left(Failure(
          message: e.toString(),
          stackTrace: st,
          code: 'edit-team-failed'
      ));
    }
  }

  @override
  Future<Either<AppException, TeamEntity?>> getTeamById(String teamId)async {
    try {
      final TeamModel? teamModel=await mockTeamDataSource.getTeamById(teamId);
      return  Right(teamModel?.toEntity());
    } on Exception catch (e,st) {
      return Left(Failure(
          message: e.toString(),
          stackTrace: st,
          code: 'get-team-byID-failed'
      ));
    }
  }
}

