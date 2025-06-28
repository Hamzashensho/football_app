import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import "package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart";

abstract class MatchRepository {
  Future<Either<AppException,List<MatchEntity>>> getMatches();
  // Define other methods like addMatch, updateMatch, deleteMatch as needed
}

