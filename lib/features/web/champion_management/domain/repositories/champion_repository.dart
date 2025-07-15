import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/mobile/match_group_detail/data/model/champion_model.dart';
import 'package:sport_app_user/features/web/champion_management/domain/entities/champion_entity.dart';

abstract class ChampionRepository {
  Future<Either<AppException,List<ChampionEntity>>> getChampions();
  Future<Either<AppException,bool>> addChampion(String title,DateTime date);
  Future<Either<AppException,void>> deleteChampion(String championId);
  Future<Either<AppException,ChampionEntity>> editChampion(String championId,String title ,DateTime date);
}

