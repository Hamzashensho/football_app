enum MatchStatus {
  upcoming,
  live,
  completed,
  postponed,
  cancelled
}

class MatchEntity {
  final String matchId;
  final DateTime date;
  final DateTime time; // Or combine with date into a single DateTime object
  final String stadiumName;
  final String? group;
  final MatchStatus status;
  final String teamAId; // FK to TeamEntity
  final String teamBId; // FK to TeamEntity
  final int? teamAScore;
  final int? teamBScore;
  final String? type; // e.g., league, cup, friendly
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

