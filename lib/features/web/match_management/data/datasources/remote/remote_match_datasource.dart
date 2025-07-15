import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_app_user/features/mobile/match_detai/data/model/match_model.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';
import 'package:sport_app_user/core/utils/logger.dart'; // Make sure this contains AppLogger

abstract class RemoteMatchDataSource {
  Future<List<MatchEntity>> getMatches();
  Future<void> addMatch(MatchEntity match);
  Future<MatchEntity> getMatchById(String id);
  Future<void> deleteMatch(String id);
  Future<void> editMatch(MatchEntity match);
}

class RemoteMatchDataSourceImpl implements RemoteMatchDataSource {
  final _championsCollection = FirebaseFirestore.instance.collection('matches');

  @override
  Future<List<MatchEntity>> getMatches() async {
    try {
      final snapshot = await _championsCollection.get();
      return snapshot.docs
          .map((doc) => MatchModel.fromMap(doc.data(), doc.id).toEntity())
          .toList();
    } catch (e) {
      AppLogger.error('Failed to get matches: $e');
      throw Exception('Failed to get matches: $e');
    }
  }

  @override
  Future<void> addMatch(MatchEntity match) async {
    try {
      final matchModel = MatchModel.fromEntity(match);
      await _championsCollection.doc().set(matchModel.toMap());
    } catch (e) {
      AppLogger.error('Failed to add match: $e');
      throw Exception('Failed to add match: $e');
    }
  }

  @override
  Future<MatchEntity> getMatchById(String id) async {
    try {
      final doc = await _championsCollection.doc(id).get();
      if (!doc.exists) throw Exception('Match not found');
      final match = MatchModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      return match.toEntity();
    } catch (e) {
      AppLogger.error('Failed to get match by ID: $e');
      throw Exception('Failed to get match by ID: $e');
    }
  }

  @override
  Future<void> deleteMatch(String id) async {
    try {
      await _championsCollection.doc(id).delete();
    } catch (e) {
      AppLogger.error( 'Failed to delete match: $e');
      throw Exception('Failed to delete match: $e');
    }
  }

  @override
  Future<void> editMatch(MatchEntity match) async {
    try {
      final matchModel = MatchModel.fromEntity(match);
      await _championsCollection.doc(match.matchId).update(matchModel.toMap());
    } catch (e) {
      AppLogger.error('Failed to update match: $e');
      throw Exception('Failed to update match: $e');
    }
  }
}
