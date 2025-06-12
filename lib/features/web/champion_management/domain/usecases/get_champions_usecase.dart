import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/entities/champion_entity.dart';
import 'package:sport_app_user/features/web/champion_management/domain/repositories/champion_repository.dart';

class GetChampionsUseCase implements UseCase<List<ChampionEntity>, NoParams> {
  final ChampionRepository championRepository;

  GetChampionsUseCase(this.championRepository);

  @override
  Future<Either<AppException, List<ChampionEntity>?>> call(NoParams params) async {
    return await championRepository.getChampions();

  }


}

