import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<Roster> getRosterFromFirebase({String? teamName}) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('rosters')
        .where('teamName', isEqualTo: teamName)
        .get();
    Roster team = Roster.fromJson(qs.docs.first.data() as Map<String, dynamic>);
    return team;
  }
}
