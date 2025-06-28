import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';

// Mock data source for matches
class MockMatchDataSource {
  Future<List<MatchEntity>> getMatches() async {
    // Simulate network delay
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      // Return some mock match data
      return [
        MatchEntity(
          matchId: 'match1',
          date: DateTime(2025, 6, 1),
          time: DateTime(2025, 6, 1, 18, 0, 0), // Assuming time is part of DateTime
          stadiumName: 'Grand Stadium',
          group: 'A',
          status: MatchStatus.upcoming,
          teamAId: 'team1',
          teamBId: 'team2',
          type: 'League',
          championId: 'champ1'
        ),
        MatchEntity(
          matchId: 'match2',
          date: DateTime(2025, 5, 20),
          time: DateTime(2025, 5, 20, 20),
          stadiumName: 'City Arena',
          group: 'B',
          status: MatchStatus.completed,
          teamAId: 'team3',
          teamBId: 'team1',
          teamAScore: 2,
          teamBScore: 1,
          type: 'Cup',
          championId: 'champ2'
        ),
      ];
    } on Exception catch (e) {
      throw Exception('Failed to get matches');
    }
  }

  // Add mock methods for addMatch, updateMatch, deleteMatch etc. as needed
}

