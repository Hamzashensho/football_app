class TeamEntity {
  final String teamId;
  final String name;
  final int? goalCount;

  TeamEntity({
    required this.teamId,
    required this.name,
    this.goalCount,
  });
}

