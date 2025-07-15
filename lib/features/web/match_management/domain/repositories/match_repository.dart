import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';

abstract class MatchRepository {
  Future<Either<AppException, List<MatchEntity>>> getMatches();
  Future<Either<AppException, void>> addMatch(MatchEntity match);
  Future<Either<AppException, MatchEntity>> getMatchById(String id);
  Future<Either<AppException, void>> deleteMatch(String id);
  Future<Either<AppException, void>> editMatch(MatchEntity match);
}


