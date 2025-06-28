import 'package:sport_app_user/features/web/notification_management/domain/entities/notification_entity.dart';

// Mock data source for notifications
class MockNotificationDataSource {
  Future<List<NotificationEntity>> getNotifications() async {
    // Simulate network delay
    try {
      await Future.delayed(const Duration(milliseconds: 100));
      // Return some mock notification data
      return [
        NotificationEntity(
          notificationId: 'notif1',
          type: NotificationType.matchReminder,
          datetime: DateTime.now().add(const Duration(hours: 2)),
          isForFavoriteTeam: true,
          title: 'Upcoming Match!',
          message: 'Your favorite team, Red Dragons, is playing soon!',
          userId: 'user1'
        ),
        NotificationEntity(
          notificationId: 'notif2',
          type: NotificationType.scoreUpdate,
          datetime: DateTime.now().subtract(const Duration(minutes: 30)),
          isForFavoriteTeam: false,
          title: 'Match Result',
          message: 'Blue Lions vs Green Eagles: 2-1',
        ),
        NotificationEntity(
          notificationId: 'notif3',
          type: NotificationType.systemAlert,
          datetime: DateTime.now().subtract(const Duration(days: 1)),
          isForFavoriteTeam: false,
          title: 'Maintenance Alert',
          message: 'Scheduled maintenance tonight at 2 AM.',
        ),
      ];
    } on Exception catch (e) {
      throw Exception('Failed to get notifications');
    }
  }

  // Add mock methods for addNotification, updateNotification, deleteNotification etc. as needed
}

