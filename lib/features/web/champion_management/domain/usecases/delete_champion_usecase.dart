import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/repositories/champion_repository.dart';

class DeleteChampionUseCase implements UseCase<void, String> {
  final ChampionRepository repository;

  DeleteChampionUseCase(this.repository);

  @override
  Future<Either<AppException,void>> call(String params) {
    return repository.deleteChampion(params);
  }
}
