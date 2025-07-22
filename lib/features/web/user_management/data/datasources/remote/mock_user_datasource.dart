import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_app_user/core/utils/logger.dart';
import 'package:sport_app_user/features/mobile/account/data/model/user_model.dart';
import 'package:sport_app_user/features/mobile/account/domain/entities/user_entity.dart';

abstract class MockUserDataSource {
  Future<List<UserEntity>> getUsers();

}

class MockUserDataSourceImpl implements MockUserDataSource {

  final _usersCollection = FirebaseFirestore.instance.collection('users');


  @override
  Future<List<UserEntity>> getUsers() async {
    //try {
      final snapshot = await _usersCollection.get();
      return snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data(), doc.id).toEntity())
          .toList();
    // } catch (e) {
    //   AppLogger.error('Get users Failed: $e');
    //   throw Exception('Get users Failed: $e');
    // }
  }


}
