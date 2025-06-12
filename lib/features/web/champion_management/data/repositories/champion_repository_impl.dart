import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/champion_management/domain/entities/champion_entity.dart';
import 'package:sport_app_user/features/web/champion_management/domain/repositories/champion_repository.dart';
import 'package:sport_app_user/features/web/champion_management/data/datasources/remote/remote_champion_datasource.dart';

class ChampionRepositoryImpl implements ChampionRepository {
  final ChampionRemoteDataSourceImpl mockChampionDataSource;

  ChampionRepositoryImpl({required this.mockChampionDataSource});

  @override
  Future<Either<AppException, List<ChampionEntity>>> getChampions()async {
    try {
       final List<ChampionEntity> championList=await mockChampionDataSource.getChampions();
       return Right(championList);
    }  catch (e,st) {
      return Left(Failure(
        message: 'Failed to get champions list',
            stackTrace: st,
            code: 'get-champions-failed',
      ));
    }

  }


  // Implement other methods like addChampion, updateChampion, deleteChampion here
}

