import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_app_user/core/utils/logger.dart';
import 'package:sport_app_user/features/mobile/match_detai/data/model/player_model.dart';
import 'package:sport_app_user/features/web/player_management/domain/entities/player_entity.dart';

abstract class MockPlayerDataSource{
  Future<List<PlayerEntity>> getPlayers();
  Future<void> addPlayer(PlayerEntity player);
  Future<PlayerEntity> getPlayerById(String id);
  Future<void> deletePlayer(String id);
  Future<void> editPlayer(PlayerEntity player);
}


class MockPlayerDataSourceImpl implements MockPlayerDataSource {
  final _playersCollection = FirebaseFirestore.instance.collection('players');

  @override
  Future<List<PlayerEntity>> getPlayers() async {
    try {
      final snapshot = await _playersCollection.get();
      return snapshot.docs
          .map((doc) => PlayerModel.fromMap(doc.data(), doc.id).toEntity())
          .toList();
    } catch (e) {
      AppLogger.error('Failed to get Players: $e');
      throw Exception('Failed to get Players: $e');
    }
  }

  @override
  Future<void> addPlayer(PlayerEntity player) async {
    try {
      final playerModel = PlayerModel.fromEntity(player);
      await _playersCollection.doc().set(playerModel.toMap());
    } catch (e) {
      AppLogger.error('Failed to add player: $e');
      throw Exception('Failed to add player: $e');
    }
  }

  @override
  Future<PlayerEntity> getPlayerById(String id) async {
    try {
      final doc = await _playersCollection.doc(id).get();
      if (!doc.exists) throw Exception('Player not found');
      final player = PlayerModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      return player.toEntity();
    } catch (e) {
      AppLogger.error('Failed to get player by ID: $e');
      throw Exception('Failed to get player by ID: $e');
    }
  }

  @override
  Future<void> deletePlayer(String id) async {
    try {
      await _playersCollection.doc(id).delete();
    } catch (e) {
      AppLogger.error( 'Failed to delete player: $e');
      throw Exception('Failed to delete player: $e');
    }
  }

  @override
  Future<void> editPlayer(PlayerEntity player) async {
    try {
      final matchModel = PlayerModel.fromEntity(player);
      await _playersCollection.doc(player.playerId).update(matchModel.toMap());
    } catch (e) {
      AppLogger.error('Failed to update player: $e');
      throw Exception('Failed to update player: $e');
    }
  }

}

