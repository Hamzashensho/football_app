import 'package:sport_app_user/features/web/player_management/domain/entities/player_entity.dart';

// Mock data source for players
class MockPlayerDataSource {
  Future<List<PlayerEntity>> getPlayers() async {
    // Simulate network delay
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // Return some mock player data
      return [
        PlayerEntity(
          playerId: 'player1',
          name: 'Alice Wonder',
          teamId: 'team1'
        ),
        PlayerEntity(
          playerId: 'player2',
          name: 'Bob The Builder',
          teamId: 'team1'
        ),
        PlayerEntity(
          playerId: 'player3',
          name: 'Charlie Chaplin',
          teamId: 'team2'
        ),
         PlayerEntity(
          playerId: 'player4',
          name: 'Diana Prince',
          teamId: 'team3'
        ),
      ];
    } on Exception catch (e) {
      throw Exception('Failed to get Players: $e');
    }
  }

  // Add mock methods for addPlayer, updatePlayer, deletePlayer etc. as needed
}

