import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/entities/champion_entity.dart';
import 'package:sport_app_user/features/web/champion_management/domain/repositories/champion_repository.dart';

class AddChampionUseCase implements UseCase<void, ChampionParams> {
  final ChampionRepository repository;

  AddChampionUseCase(this.repository);

  @override
  Future<Either<AppException,bool>> call(ChampionParams params) {
    return repository.addChampion(params.title,params.date);
  }
}

class ChampionParams{
  final String? championId;
  final DateTime date;
  final String title;
  ChampionParams({this.championId, required this.date, required this.title});
}