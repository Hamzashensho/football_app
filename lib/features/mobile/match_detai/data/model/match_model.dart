class MatchModel {
  final String matchId;
  final DateTime date;
  final String time;
  final String stadiumName;
  final String group;
  final String status; // e.g. upcoming, live, finished
  final String teamAId;
  final String teamBId;
  final int teamAScore;
  final int teamBScore;
  final String type; // quarter, semi-final, final
  final String championId;

  MatchModel({
    required this.matchId,
    required this.date,
    required this.time,
    required this.stadiumName,
    required this.group,
    required this.status,
    required this.teamAId,
    required this.teamBId,
    required this.teamAScore,
    required this.teamBScore,
    required this.type,
    required this.championId,
  });

  factory MatchModel.fromMap(Map<String, dynamic> map, String id) {
    return MatchModel(
      matchId: id,
      date: DateTime.parse(map['date']),
      time: map['time'],
      stadiumName: map['stadiumName'],
      group: map['group'],
      status: map['status'],
      teamAId: map['teamAId'],
      teamBId: map['teamBId'],
      teamAScore: map['teamAScore'],
      teamBScore: map['teamBScore'],
      type: map['type'],
      championId: map['championId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'time': time,
      'stadiumName': stadiumName,
      'group': group,
      'status': status,
      'teamAId': teamAId,
      'teamBId': teamBId,
      'teamAScore': teamAScore,
      'teamBScore': teamBScore,
      'type': type,
      'championId': championId,
    };
  }
}
