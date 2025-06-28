import 'package:sport_app_user/features/web/match_event_management/domain/entities/match_event_entity.dart';

// Mock data source for match events
class MockMatchEventDataSource {
  Future<List<MatchEventEntity>> getMatchEvents(String matchId) async {
    // Simulate network delay
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      // Return some mock match event data, filtered by matchId if necessary for more realism
      // For simplicity, returning a generic list here, assuming the BLoC/UseCase will filter or request appropriately
      if (matchId == 'match1') {
          return [
              MatchEventEntity(
                  matchEventId: 'event1',
                  eventType: MatchEventType.goal,
                  minute: 30,
                  playerName: 'Alice Wonder',
                  teamId: 'team1',
                  matchId: 'match1'
              ),
              MatchEventEntity(
                  matchEventId: 'event2',
                  eventType: MatchEventType.yellowCard,
                  minute: 45,
                  playerName: 'Charlie Chaplin',
                  teamId: 'team2',
                  matchId: 'match1'
              ),
          ];
      } else if (matchId == 'match2') {
          return [
              MatchEventEntity(
                  matchEventId: 'event3',
                  eventType: MatchEventType.goal,
                  minute: 15,
                  playerName: 'Diana Prince',
                  teamId: 'team3',
                  matchId: 'match2'
              ),
               MatchEventEntity(
                  matchEventId: 'event4',
                  eventType: MatchEventType.goal,
                  minute: 75,
                  playerName: 'Diana Prince',
                  teamId: 'team3',
                  matchId: 'match2'
              ),
               MatchEventEntity(
                  matchEventId: 'event5',
                  eventType: MatchEventType.redCard,
                  minute: 88,
                  playerName: 'Alice Wonder',
                  teamId: 'team1',
                  matchId: 'match2'
              ),
          ];
      }
      return [];
    } on Exception catch (e) {
      throw Exception('Failed to get match events');
    }

  }

  // Add mock methods for addMatchEvent, updateMatchEvent, deleteMatchEvent etc. as needed
}

