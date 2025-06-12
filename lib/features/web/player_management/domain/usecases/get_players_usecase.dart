import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/player_management/domain/entities/player_entity.dart';
import 'package:sport_app_user/features/web/player_management/domain/repositories/player_repository.dart';


class GetPlayersUseCase implements UseCase<List<PlayerEntity>, NoParams> {
  final PlayerRepository playerRepository;

  GetPlayersUseCase(this.playerRepository);

  @override
  Future<Either<AppException,List<PlayerEntity>>> call(NoParams params) async {
    return await playerRepository.getPlayers();
  }
}

