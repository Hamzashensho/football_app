class MatchEventModel {
  final String eventId;
  final String eventType; // goal, yellowCard, redCard
  final int minute;
  final String playerName;
  final String matchId;
  final String teamId;

  MatchEventModel({
    required this.eventId,
    required this.eventType,
    required this.minute,
    required this.playerName,
    required this.matchId,
    required this.teamId,
  });

  factory MatchEventModel.fromMap(Map<String, dynamic> map, String id) {
    return MatchEventModel(
      eventId: id,
      eventType: map['eventType'],
      minute: map['minute'],
      playerName: map['playerName'],
      matchId: map['matchId'],
      teamId: map['teamId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventType': eventType,
      'minute': minute,
      'playerName': playerName,
      'matchId': matchId,
      'teamId': teamId,
    };
  }
}
