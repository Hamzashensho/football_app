import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_app_user/core/utils/logger.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/entities/match_event_entity.dart';

abstract class  RemoteMatchEventDataSource{
  Future<List<MatchEventEntity>> getMatchEvents(String matchId);
  Future<void> addMatchEvent(MatchEventEntity event);
  Future<void> updateMatchEvent(MatchEventEntity event);
  Future<void> deleteMatchEvent(String matchId, String matchEventId);
}

class RemoteMatchEventDataSourceImp implements RemoteMatchEventDataSource {


  CollectionReference<Map<String, dynamic>> _eventsRef(String matchId) =>
      FirebaseFirestore.instance.collection('matches').doc(matchId).collection('events');

  @override
  Future<List<MatchEventEntity>> getMatchEvents(String matchId) async {
    try {
      final snapshot = await _eventsRef(matchId).get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return MatchEventEntity(
          matchEventId: doc.id,
          eventType: MatchEventType.values.byName(data['eventType']),
          minute: data['minute'],
          playerName: data['playerName'],
          teamId: data['teamId'],
          matchId: matchId,
        );
      }).toList();
    } catch (e) {
      AppLogger.error('Failed to get match events: $e');
      throw Exception('Failed to get match events: $e');
    }
  }

  @override
  Future<void> addMatchEvent(MatchEventEntity event) async {
    try {
      await _eventsRef(event.matchId).add({
        'eventType': event.eventType.name,
        'minute': event.minute,
        'playerName': event.playerName,
        'teamId': event.teamId,
      });
    } catch (e) {
      AppLogger.error('Failed to add match event: $e');
      throw Exception('Failed to add match event: $e');
    }
  }

  @override
  Future<void> updateMatchEvent(MatchEventEntity event) async {
    try {
      await _eventsRef(event.matchId).doc(event.matchEventId).update({
        'eventType': event.eventType.name,
        'minute': event.minute,
        'playerName': event.playerName,
        'teamId': event.teamId,
      });
    } catch (e) {
      AppLogger.error('Failed to update match event: $e');
      throw Exception('Failed to update match event: $e');
    }
  }

  @override
  Future<void> deleteMatchEvent(String matchId, String matchEventId) async {
    try {
      await _eventsRef(matchId).doc(matchEventId).delete();
    } catch (e) {
      AppLogger.error('Failed to delete match event: $e');
      throw Exception('Failed to delete match event: $e');
    }
  }

}

