import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/entities/champion_entity.dart';
import 'package:sport_app_user/features/web/champion_management/domain/repositories/champion_repository.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/add_champion_usecase.dart';

class EditChampionUseCase implements UseCase<ChampionEntity, ChampionParams> {
  final ChampionRepository repository;

  EditChampionUseCase(this.repository);

  @override
  Future<Either<AppException,ChampionEntity>> call(ChampionParams params) {
    return repository.editChampion(params.championId??'',params.title,params.date);
  }
}
