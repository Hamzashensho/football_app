import 'package:sport_app_user/features/web/user_management/domain/entities/user_entity.dart';

// Mock data source for users
class MockUserDataSource {
  Future<List<UserEntity>> getUsers() async {
    // Simulate network delay
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      // Return some mock user data
      return [
        UserEntity(
          userId: 'user1',
          firstName: 'John',
          lastName: 'Doe',
          dob: DateTime(1990, 1, 1),
          phoneNumber: '123-456-7890',
          email: 'john.doe@example.com',
          country: 'USA',
          favoriteTeamId: 'team1'
        ),
        UserEntity(
          userId: 'user2',
          firstName: 'Jane',
          lastName: 'Smith',
          dob: DateTime(1992, 5, 15),
          phoneNumber: '987-654-3210',
          email: 'jane.smith@example.com',
          country: 'Canada',
          favoriteTeamId: 'team2'
        ),
      ];
    } on Exception catch (e) {
      throw Exception('Get users Failed');
    }
  }

  // Add mock methods for addUser, updateUser, deleteUser etc. as needed
}
