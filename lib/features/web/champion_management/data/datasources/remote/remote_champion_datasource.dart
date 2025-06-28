import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_app_user/features/mobile/match_group_detail/data/model/champion_model.dart';
abstract class ChampionRemoteDataSource{
  Future<void> addChampion(ChampionModel champion);
  Future<void> editChampion(ChampionModel champion);
  Future<void> deleteChampion(String championId);
  Future<List<ChampionModel>> getChampions();
  Future<ChampionModel?> getChampionById(String championId);
}
class ChampionRemoteDataSourceImpl implements ChampionRemoteDataSource{
  final _championsCollection = FirebaseFirestore.instance.collection('champions');

  @override
  Future<void> addChampion(ChampionModel champion)async {
    try {
      final docRef = _championsCollection.doc();
      await docRef.set(champion.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteChampion(String championId)async {
    try {
      final docRef = _championsCollection.doc(championId);
      await docRef.delete();
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> editChampion(ChampionModel champion)async {
    try {
      final docRef = _championsCollection.doc(champion.championId);
      await docRef.update(champion.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ChampionModel?> getChampionById(String championId) async {
    try {
      final doc = await _championsCollection.doc(championId).get();
      if (doc.exists) {
        return ChampionModel.fromMap(doc.data()!, doc.id);
      }
      return null;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ChampionModel>> getChampions()async {
    try {
      final querySnapshot = await _championsCollection.get();
      return querySnapshot.docs.map((doc) {
        return ChampionModel.fromMap( doc.data(),doc.id);
      }).toList();
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

}

