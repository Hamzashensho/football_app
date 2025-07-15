import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';

class MatchModel {
  final String matchId;
  final DateTime date;
  final String time;
  final String stadiumName;
  final String group;
  final String type;
  final String championId;
  final String status;
  final String teamAId;
  final String teamBId;
  final int? teamAScore;
  final int? teamBScore;

  MatchModel({
    required this.matchId,
    required this.date,
    required this.time,
    required this.stadiumName,
    required this.group,
    required this.type,
    required this.championId,
    required this.status,
    required this.teamAId,
    required this.teamBId,
    this.teamAScore,
    this.teamBScore,
  });

  factory MatchModel.fromMap(Map<String, dynamic> map, String id) {
    return MatchModel(
      matchId: id,
      date: (map['date'] as Timestamp).toDate(),
      time: map['time'],
      stadiumName: map['stadiumName'],
      group: map['group'],
      type: map['type'],
      championId: map['championId'],
      status: map['status'],
      teamAId: map['teamAId'],
      teamBId: map['teamBId'],
      teamAScore: map['teamAScore'],
      teamBScore: map['teamBScore'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'time': time,
      'stadiumName': stadiumName,
      'group': group,
      'type': type,
      'championId': championId,
      'status': status,
      'teamAId': teamAId,
      'teamBId': teamBId,
      'teamAScore': teamAScore,
      'teamBScore': teamBScore,
    };
  }

  MatchEntity toEntity() => MatchEntity(
    matchId: matchId,
    date: date,
    time: time,
    stadiumName: stadiumName,
    group: group,
    type: type,
    championId: championId,
    status: status,
    teamAId: teamAId,
    teamBId: teamBId,
    teamAScore: teamAScore,
    teamBScore: teamBScore,
  );

  factory MatchModel.fromEntity(MatchEntity entity) => MatchModel(
    matchId: entity.matchId,
    date: entity.date,
    time: entity.time,
    stadiumName: entity.stadiumName,
    group: entity.group??'',
    type: entity.type??'',
    championId: entity.championId??'',
    status: entity.status??'',
    teamAId: entity.teamAId,
    teamBId: entity.teamBId,
    teamAScore: entity.teamAScore,
    teamBScore: entity.teamBScore,
  );
}
