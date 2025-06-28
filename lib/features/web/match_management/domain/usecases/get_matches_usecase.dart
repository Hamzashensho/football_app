import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';
import 'package:sport_app_user/features/web/match_management/domain/repositories/match_repository.dart';


class GetMatchesUseCase implements UseCase<List<MatchEntity>, NoParams> {
  final MatchRepository matchRepository;

  GetMatchesUseCase(this.matchRepository);

  @override
  Future<Either<AppException,List<MatchEntity>>> call(NoParams params) async {
    return await matchRepository.getMatches();
  }
}

