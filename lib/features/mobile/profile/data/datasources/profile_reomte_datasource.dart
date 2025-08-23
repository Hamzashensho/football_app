import 'package:sport_app_user/core/utils/logger.dart';
import 'package:sport_app_user/features/mobile/account/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<UserEntity> getUserData(String userId);
  Future<void> editUserData(UserModel user);

}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> editUserData(UserModel user) async {
   try {
     await _usersCollection.doc(user.userId).update(user.toJson());
   } on Exception catch (e) {
     AppLogger.error('Failed to edit user: $e');
     throw Exception('Failed to edit user: $e');
   }
  }

  @override
  Future<UserEntity> getUserData(String userId) async {
    try {
      final snapshot = await _usersCollection.doc(userId).get();

      if (!snapshot.exists || snapshot.data() == null) {
        throw Exception('User with ID $userId not found.');
      }

      final userModel = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      return userModel.toEntity();
    } on Exception catch (e) {
      AppLogger.error('Failed to get User data $e');
      throw Exception('Failed to get User data $e');

    }
  }






}
