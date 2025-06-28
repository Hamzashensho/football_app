import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/notification_management/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<AppException,List<NotificationEntity>>> getNotifications();
  // Define other methods like addNotification, updateNotification, deleteNotification as needed
}

