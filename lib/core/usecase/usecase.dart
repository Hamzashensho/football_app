import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sport_app_user/core/error/exceptions.dart';

abstract class UseCase<Type, Params> {
  Future<Either<AppException,Type?>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}



