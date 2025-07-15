import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';

class TeamModel extends TeamEntity {
   TeamModel({
    required super.teamId,
    required super.name,
    required super.goalCount,
  });

  factory TeamModel.fromMap(Map<String, dynamic> map, String id) {
    return TeamModel(
      teamId: id,
      name: map['name'] ?? '',
      goalCount: map['goalCount'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'goalCount': goalCount,
    };
  }

  factory TeamModel.fromEntity(TeamEntity entity) {
    return TeamModel(
      teamId: entity.teamId,
      name: entity.name,
      goalCount: entity.goalCount,
    );
  }

  TeamEntity toEntity() {
    return TeamEntity(
      teamId: teamId,
      name: name,
      goalCount: goalCount,
    );
  }
}
