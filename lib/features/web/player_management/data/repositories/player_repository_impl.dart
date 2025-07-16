import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/player_management/domain/entities/player_entity.dart';
import 'package:sport_app_user/features/web/player_management/domain/repositories/player_repository.dart';
import 'package:sport_app_user/features/web/player_management/data/datasources/remote/remote_player_datasource.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final MockPlayerDataSource mockPlayerDataSource;

  PlayerRepositoryImpl({required this.mockPlayerDataSource});

  @override
  Future<Either<AppException, List<PlayerEntity>>> getPlayers() async {
    try {
      final players = await mockPlayerDataSource.getPlayers();
      return Right(players);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'get-players-failed',
      ));
    }
  }

  @override
  Future<Either<AppException, void>> addPlayer(PlayerEntity player) async {
    try {
      await mockPlayerDataSource.addPlayer(player);
      return const Right(null);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'add-player-failed',
      ));
    }
  }

  @override
  Future<Either<AppException, PlayerEntity>> getPlayerById(String id) async {
    try {
      final match = await mockPlayerDataSource.getPlayerById(id);
      return Right(match);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'get-player-by-id-failed',
      ));
    }
  }

  @override
  Future<Either<AppException, void>> deletePlayer(String id) async {
    try {
      await mockPlayerDataSource.deletePlayer(id);
      return const Right(null);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'delete-player-failed',
      ));
    }
  }

  @override
  Future<Either<AppException, void>> editPlayer(PlayerEntity player) async {
    try {
      await mockPlayerDataSource.editPlayer(player);
      return const Right(null);
    } catch (e, st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'edit-player-failed',
      ));
    }
  }
  
}

