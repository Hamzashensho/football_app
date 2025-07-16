import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/player_management/domain/repositories/player_repository.dart';



class DeletePlayerUseCase implements UseCase<void, String> {
  final PlayerRepository playerRepository;

  DeletePlayerUseCase(this.playerRepository);

  @override
  Future<Either<AppException,void>> call(String params) async {
    return await playerRepository.deletePlayer(params);
  }
}

