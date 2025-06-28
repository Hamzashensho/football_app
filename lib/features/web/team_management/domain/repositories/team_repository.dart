import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';

abstract class TeamRepository {
  Future<Either<AppException,List<TeamEntity>>> getTeams();
  // Define other methods like addTeam, updateTeam, deleteTeam as needed
}

