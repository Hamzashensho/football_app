class TeamEntity {
  final String teamId;
  final String name;
  final int? goalCount; // ERD shows goalCount
  final String? championId; // ERD shows championId as FK

  TeamEntity({
    required this.teamId,
    required this.name,
    this.goalCount,
    this.championId,
  });
}

