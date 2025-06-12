class PlayerEntity {
  final String playerId;
  final String name;
  final String teamId; // FK to TeamEntity

  PlayerEntity({
    required this.playerId,
    required this.name,
    required this.teamId,
  });
}

