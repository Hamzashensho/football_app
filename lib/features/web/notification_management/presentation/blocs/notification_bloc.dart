import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/notification_management/domain/entities/notification_entity.dart';
import 'package:sport_app_user/features/web/notification_management/domain/usecases/get_notifications_usecase.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationBloc({required this.getNotificationsUseCase})
    : super(NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    // Register other event handlers here
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    final notifications = await getNotificationsUseCase.call(NoParams());

    notifications.fold(
      (failure) => emit(const NotificationError('Failed to load notifications')),
      (notifications) => emit(NotificationLoaded(notifications)),
    );
  }
}
