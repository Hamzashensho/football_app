import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/champion_management/domain/entities/champion_entity.dart';

abstract class ChampionRepository {
  Future<Either<AppException,List<ChampionEntity>>> getChampions();
  // Define other methods like addChampion, updateChampion, deleteChampion as needed
}

