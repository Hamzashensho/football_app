import 'package:sport_app_user/features/web/player_management/domain/entities/player_entity.dart';

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

  factory PlayerModel.fromEntity(PlayerEntity entity) {
    return PlayerModel(
      playerId: entity.playerId,
      name: entity.name,
      teamId: entity.teamId,
    );
  }

  PlayerEntity toEntity() {
    return PlayerEntity(
      playerId: playerId,
      name: name,
      teamId: teamId,
    );
  }
}
