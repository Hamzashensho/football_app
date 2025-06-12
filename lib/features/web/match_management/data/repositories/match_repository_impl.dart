import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';
import 'package:sport_app_user/features/web/match_management/domain/repositories/match_repository.dart';
import 'package:sport_app_user/features/web/match_management/data/datasources/remote/mock_match_datasource.dart';

class MatchRepositoryImpl implements MatchRepository {
  final MockMatchDataSource mockMatchDataSource;

  MatchRepositoryImpl({required this.mockMatchDataSource});

  @override
  Future<Either<AppException,List<MatchEntity>>> getMatches() async {
    try {
      final List<MatchEntity> matches= await mockMatchDataSource.getMatches();
      return Right(matches);
    } on Exception catch (e,st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'get-matches-failed'
      ));
    }
  }
  
  // Implement other methods like addMatch, updateMatch, deleteMatch here
}

