import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/core/usecase/usecase.dart';
import 'package:sport_app_user/features/web/notification_management/domain/entities/notification_entity.dart';
import 'package:sport_app_user/features/web/notification_management/domain/repositories/notification_repository.dart';

class GetNotificationsUseCase implements UseCase<List<NotificationEntity>, NoParams> {
  final NotificationRepository notificationRepository;

  GetNotificationsUseCase(this.notificationRepository);

  @override
  Future<Either<AppException,List<NotificationEntity>>> call(NoParams params) async {
    return await notificationRepository.getNotifications();
  }
}

