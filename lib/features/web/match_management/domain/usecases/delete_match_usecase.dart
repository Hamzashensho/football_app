import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';
import 'package:sport_app_user/features/web/match_management/domain/repositories/match_repository.dart';


class DeleteMatchUseCase implements UseCase<void, String> {
  final MatchRepository matchRepository;

  DeleteMatchUseCase(this.matchRepository);

  @override
  Future<Either<AppException,void>> call(String params) async {
    return await matchRepository.deleteMatch(params);
  }
}

