import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';

abstract class TeamRepository {
  Future<Either<AppException,List<TeamEntity>>> getTeams();
  Future<Either<AppException,void>> addTeam(TeamEntity teamEntity);
  Future<Either<AppException,TeamEntity?>> getTeamById(String teamId);
  Future<Either<AppException,void>> deleteTeam(String teamId);
  Future<Either<AppException,void>> editTeam(TeamEntity teamEntity);}

