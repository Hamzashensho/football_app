import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/player_management/domain/entities/player_entity.dart';
import 'package:sport_app_user/features/web/player_management/domain/repositories/player_repository.dart';



class AddPlayerUseCase implements UseCase<void, PlayerEntity> {
  final PlayerRepository playerRepository;

  AddPlayerUseCase(this.playerRepository);

  @override
  Future<Either<AppException,void>> call(PlayerEntity params) async {
    return await playerRepository.addPlayer(params);
  }
}

