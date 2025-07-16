import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/player_management/domain/entities/player_entity.dart';

abstract class PlayerRepository {
  Future<Either<AppException, List<PlayerEntity>>> getPlayers();
  Future<Either<AppException, void>> addPlayer(PlayerEntity player);
  Future<Either<AppException, PlayerEntity>> getPlayerById(String id);
  Future<Either<AppException, void>> deletePlayer(String id);
  Future<Either<AppException, void>> editPlayer(PlayerEntity player);
}

