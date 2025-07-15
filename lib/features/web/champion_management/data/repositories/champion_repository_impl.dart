import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/utils/logger.dart';
import 'package:sport_app_user/features/mobile/match_group_detail/data/model/champion_model.dart';
import 'package:sport_app_user/features/web/champion_management/domain/entities/champion_entity.dart';
import 'package:sport_app_user/features/web/champion_management/domain/repositories/champion_repository.dart';
import 'package:sport_app_user/features/web/champion_management/data/datasources/remote/remote_champion_datasource.dart';

class ChampionRepositoryImpl implements ChampionRepository {
  final ChampionRemoteDataSource mockChampionDataSource;

  ChampionRepositoryImpl({required this.mockChampionDataSource});

  @override
  Future<Either<AppException, List<ChampionEntity>>> getChampions()async {
    try {
       final List<ChampionModel> championModelList=await mockChampionDataSource.getChampions();
       final List<ChampionEntity> championList = championModelList.map((model) => model.toEntity()).toList();
       return Right(championList);
    }  catch (e,st) {
      AppLogger.error(e.toString());
      return Left(Failure(
        message: 'Failed to get champions list ',
            stackTrace: st,
            code: 'get-champions-failed',
      ));
    }

  }

  @override
  Future<Either<AppException,bool>> addChampion(String title,DateTime date)async {
    try{
      await mockChampionDataSource.addChampion(ChampionModel(
        date: date,
        title: title,
      ));
      return const Right(true);
    }catch(e,st){
      return Left(Failure(
        message: 'Failed to add champion',
        stackTrace: st,
        code:'add-champions-failed'
      ));
    }
  }
  @override
  Future<Either<AppException,void>> deleteChampion(String championId)async {
    try{
      await mockChampionDataSource.deleteChampion(
         championId
      );
      return const Right(null);
    }catch(e,st){
      return Left(Failure(
          message: 'Failed to delete champion',
          stackTrace: st,
          code:'delete-champions-failed'
      ));
    }
  }
  @override
  Future<Either<AppException,ChampionEntity>> editChampion(String championId,String title,DateTime date)async {
    try{
      await mockChampionDataSource.editChampion(ChampionModel(
        championId: championId,
        date: date,
        title: title,
      ));
      final ChampionModel? championModel=await mockChampionDataSource.getChampionById(championId);
      final ChampionEntity? championEntity=championModel?.toEntity();
      if(championEntity?.championId.isEmpty??true){
        return const Left(Failure(message: 'champion id is empty'));
      }
      return  Right(championEntity!);
    }catch(e,st){
      AppLogger.error(e.toString());
      return Left(Failure(
          message: 'Failed to edit champion',
          stackTrace: st,
          code:'edit-champions-failed'
      ));
    }
  }

}

