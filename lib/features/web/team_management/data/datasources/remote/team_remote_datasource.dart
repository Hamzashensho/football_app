import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_app_user/features/web/team_management/data/model/team_model.dart';

abstract class TeamRemoteDataSource{
  Future<List<TeamModel>> getTeams();
  Future<void> addTeam(TeamModel teamModel);
  Future<TeamModel?> getTeamById(String teamId);
  Future<void> deleteTeam(String teamId);
  Future<void> editTeam(TeamModel teamModel);
}

class TeamRemoteDataSourceImpl implements TeamRemoteDataSource{
  final _teamsCollection=FirebaseFirestore.instance.collection('teams');

  @override
  Future<List<TeamModel>> getTeams() async {
    try {
      final querySnapShot=await _teamsCollection.get();
     return querySnapShot.docs.map((doc){
        return TeamModel.fromMap(doc.data(), doc.id);
      }).toList();
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addTeam(TeamModel teamModel) async {
    try {
      final docRef=_teamsCollection.doc();
      await docRef.set(teamModel.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<TeamModel?> getTeamById(String teamId) async {
    try {
      final doc=await _teamsCollection.doc(teamId).get();
      if(doc.exists){
        return TeamModel.fromMap(doc.data()??{}, doc.id);
      }
      return null;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteTeam(String teamId) async {
    try {
      await _teamsCollection.doc(teamId).delete();
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> editTeam(TeamModel teamModel) async {
    try {
      final docRef=_teamsCollection.doc(teamModel.teamId);
      await docRef.update(teamModel.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    }
  }



}

