enum NotificationType {
  matchReminder,
  scoreUpdate,
  favoriteTeamNews,
  systemAlert,
  promotional,
  other
}

class NotificationEntity {
  final String notificationId;
  final NotificationType type;
  final DateTime datetime;
  final bool isForFavoriteTeam;
  final String? title; // Added for better UX
  final String message; // Added for better UX
  final String? userId; // Optional: if a notification can be user-specific beyond the `users.notifications` object

  NotificationEntity({
    required this.notificationId,
    required this.type,
    required this.datetime,
    required this.isForFavoriteTeam,
    this.title,
    required this.message,
    this.userId,
  });
}

