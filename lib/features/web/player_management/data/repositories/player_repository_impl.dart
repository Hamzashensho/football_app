import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/player_management/domain/entities/player_entity.dart';
import 'package:sport_app_user/features/web/player_management/domain/repositories/player_repository.dart';
import 'package:sport_app_user/features/web/player_management/data/datasources/remote/remote_player_datasource.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final MockPlayerDataSource mockPlayerDataSource;

  PlayerRepositoryImpl({required this.mockPlayerDataSource});

  @override
  Future<Either<AppException,List<PlayerEntity>>> getPlayers() async {
    try {
      final List<PlayerEntity> players= await mockPlayerDataSource.getPlayers();
      return Right(players);
    } on Exception catch (e,st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'get-players-failed'
      ));
    }
  }
  
  // Implement other methods like addPlayer, updatePlayer, deletePlayer here
}

