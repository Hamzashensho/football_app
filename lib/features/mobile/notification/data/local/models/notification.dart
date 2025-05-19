class NotificationModel {
  final String notificationId;
  final String type; // newMatch, endOfMatch, newGoal, etc.
  final DateTime datetime;
  final bool isForFavoriteTeam;

  NotificationModel({
    required this.notificationId,
    required this.type,
    required this.datetime,
    required this.isForFavoriteTeam,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map, String id) {
    return NotificationModel(
      notificationId: id,
      type: map['type'],
      datetime: DateTime.parse(map['datetime']),
      isForFavoriteTeam: map['isForFavoriteTeam'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'datetime': datetime.toIso8601String(),
      'isForFavoriteTeam': isForFavoriteTeam,
    };
  }
}
