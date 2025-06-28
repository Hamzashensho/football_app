import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/user_management/domain/entities/user_entity.dart';
import 'package:sport_app_user/features/web/user_management/domain/usecases/get_users_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;

  UserBloc({required this.getUsersUseCase}) : super(UserInitial()) {
    on<LoadUsers>(_onLoadUsers);
    // Register other event handlers here
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final usecase = await getUsersUseCase.call(NoParams());
    usecase.fold((failure)=>emit(const UserError('Failed to load users'))
        , (users)=>emit(UserLoaded(users)));

  }
}

