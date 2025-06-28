import 'package:dartz/dartz.dart';
import 'package:sport_app_user/core/error/exceptions.dart';
import 'package:sport_app_user/features/web/notification_management/domain/entities/notification_entity.dart';
import 'package:sport_app_user/features/web/notification_management/domain/repositories/notification_repository.dart';
import 'package:sport_app_user/features/web/notification_management/data/datasources/remote/mock_notification_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final MockNotificationDataSource mockNotificationDataSource;

  NotificationRepositoryImpl({required this.mockNotificationDataSource});

  @override
  Future<Either<AppException,List<NotificationEntity>>> getNotifications() async {
    try {
      final List<NotificationEntity> notifications= await mockNotificationDataSource.getNotifications();
      return Right(notifications);
    } on Exception catch (e,st) {
      return Left(Failure(
        message: e.toString(),
        stackTrace: st,
        code: 'get-notifications-failed'
      ));
    }
  }
  
  // Implement other methods like addNotification, updateNotification, deleteNotification here
}

