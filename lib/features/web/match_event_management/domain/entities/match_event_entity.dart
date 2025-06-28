enum MatchEventType {
  goal,
  yellowCard,
  redCard,
  substitution,
  foul,
  offside,
  corner,
  penalty,
  other
}

class MatchEventEntity {
  final String matchEventId;
  final MatchEventType eventType;
  final int minute;
  final String? playerName; // Optional, as some events might not be player-specific
  final String teamId; // FK to TeamEntity (team that committed/benefited from event)
  final String matchId; // FK to MatchEntity

  MatchEventEntity({
    required this.matchEventId,
    required this.eventType,
    required this.minute,
    this.playerName,
    required this.teamId,
    required this.matchId,
  });
}

