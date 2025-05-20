class PlayerModel {
  final String playerId;
  final String name;
  final String teamId;

  PlayerModel({
    required this.playerId,
    required this.name,
    required this.teamId,
  });

  factory PlayerModel.fromMap(Map<String, dynamic> map, String id) {
    return PlayerModel(
      playerId: id,
      name: map['name'],
      teamId: map['teamId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'teamId': teamId,
    };
  }
}
