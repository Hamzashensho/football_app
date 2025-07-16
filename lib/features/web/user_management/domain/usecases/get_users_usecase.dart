import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/web/user_management/domain/repositories/user_repository.dart';

class GetUsersUseCase implements UseCase<List<UserEntity>, NoParams> {
  final UserRepository userRepository;

  GetUsersUseCase(this.userRepository);

  @override
  Future<Either<AppException,List<UserEntity>>> call(NoParams params) async {
    return await userRepository.getUsers();
  }
}


