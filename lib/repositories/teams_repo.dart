import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:lob_app/models/player.dart';
import 'package:lob_app/models/roster.dart';
import 'package:lob_app/models/team.dart';

class TeamsRepo {
  TeamsRepo._internal(); // Private constructor for singleton behavior

  static final TeamsRepo _instance =
      TeamsRepo._internal(); // Singleton instance

  factory TeamsRepo() {
    return _instance;
  }

  Future<List<Team>> getTeamsFromFirebase() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('teams').get();
    List<Team> teams = qs.docs
        .map((doc) => Team.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return teams;
  }

  Future<List<Roster>> getRosterFromFirebase() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('rosters').get();
    List<Roster> team = qs.docs
        .map((doc) => Roster.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return team;
  }

  Future<void> createTeamInFirebase(
      {String? name, String? nameLessLogo, String? namedLogo}) async {
    Map<String, dynamic> team = {
      "name": name,
      "namedLogo": namedLogo,
      "namelessLogo": nameLessLogo
    };
    await FirebaseFirestore.instance.collection('teams').add(team);
    await FirebaseFirestore.instance
        .collection('rosters')
        .add({"teamName": name, "players": []});
  }

  Future<void> removeTeamFromFirebase(Team team) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('teams')
        .where("name", isEqualTo: team.name)
        .get();
    final querySnapshot2 = await FirebaseFirestore.instance
        .collection('rosters')
        .where("teamName", isEqualTo: team.name)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      // Loop through each matching document and delete it
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
        print('Document "${doc.id}" deleted successfully');
      }
    } else {
      print('No documents found with name "${team.name}"');
    }
    if (querySnapshot2.docs.isNotEmpty) {
      // Loop through each matching document and delete it
      for (var doc in querySnapshot2.docs) {
        await doc.reference.delete();
        print('Document "${doc.id}" deleted successfully');
      }
    } else {
      print('No documents found with name "${team.name}"');
    }
  }

  Future<void> addPlayerToFirebase(
      {required Player player, required String teamName}) async {
    Map<String, dynamic> temp = player.toJson();
    final querySnapshot = await FirebaseFirestore.instance
        .collection('rosters')
        .where("teamName", isEqualTo: teamName)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      // Loop through each matching document and delete it
      for (var doc in querySnapshot.docs) {
        await doc.reference.update({
          "teamName": teamName,
          "players": [temp, ...doc.data()['players']]
        });
      }
    } else {
      print('No team found with name "$teamName"');
    }
  }

  Future<void> removePlayerFromFirebase(
      {required Player player, required String teamName}) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('rosters')
        .where("teamName", isEqualTo: teamName)
        .get();

    Map<String, dynamic> temp = player.toJson();
    List<dynamic> allPlayers = [];
    for (var iter in querySnapshot.docs.first['players']) {
      // ignore: prefer_const_constructors
      if (!(DeepCollectionEquality().equals(iter, temp))) {
        allPlayers.add(iter);
      }
    }

    await querySnapshot.docs.first.reference
        .update({"teamName": teamName, "players": allPlayers});
  }
}
