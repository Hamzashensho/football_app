import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/player_management/domain/entities/player_entity.dart';

abstract class PlayerRepository {
  Future<Either<AppException,List<PlayerEntity>>> getPlayers();
  // Define other methods like addPlayer, updatePlayer, deletePlayer as needed
}

