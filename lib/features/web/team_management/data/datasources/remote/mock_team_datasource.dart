import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';

// Mock data source for teams
class MockTeamDataSource {
  Future<List<TeamEntity>> getTeams() async {
    // Simulate network delay
    try {
      await Future.delayed(const Duration(milliseconds: 400));
      // Return some mock team data
      return [
        TeamEntity(
          teamId: 'team1',
          name: 'Red Dragons',
          goalCount: 25,
          championId: 'champ1'
        ),
        TeamEntity(
          teamId: 'team2',
          name: 'Blue Lions',
          goalCount: 30,
        ),
        TeamEntity(
          teamId: 'team3',
          name: 'Green Eagles',
          goalCount: 18,
          championId: 'champ2'
        ),
      ];
    } on Exception catch (e) {
      throw Exception('Get teams failed');
    }
  }

  // Add mock methods for addTeam, updateTeam, deleteTeam etc. as needed
}

