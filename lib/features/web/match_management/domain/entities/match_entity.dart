enum MatchStatus {
  Upcoming,
  Live,
  Completed,
  Postponed,
  Cancelled
}

enum MatchType{
  Quarter,
  Final,
  Semi,
}
extension MatchTypeExtension on MatchType {
  String get displayTypeName {
    switch (this) {
      case MatchType.Final:
        return 'Final ';
      case MatchType.Quarter:
        return 'Quarter';
      case MatchType.Semi:
        return 'Semi-final';
    }
  }
}

extension MatchStatusExtension on MatchStatus {
  String get displayStatusName {
    switch (this) {
      case MatchStatus.Upcoming:
        return 'Upcoming ';
      case MatchStatus.Cancelled:
        return 'Cancelled';
      case MatchStatus.Completed:
        return 'Completed';
      case MatchStatus.Live:
        return 'Live';
      case MatchStatus.Postponed:
        return 'Postponed';
    }
  }
}

class MatchEntity {
  final String matchId;
  final DateTime date;
  final String time;
  final String stadiumName;
  final String? group;
  final String? status;
  final String teamAId; // FK to TeamEntity
  final String teamBId; // FK to TeamEntity
  final int? teamAScore;
  final int? teamBScore;
  final String? type; // e.g., final, semi,quart
  final String? championId; // FK to ChampionEntity

  MatchEntity({
    required this.matchId,
    required this.date,
    required this.time,
    required this.stadiumName,
    this.group,
    required this.status,
    required this.teamAId,
    required this.teamBId,
    this.teamAScore,
    this.teamBScore,
    this.type,
    this.championId,
  });


}

