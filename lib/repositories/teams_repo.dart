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

  Future<List<Roster>> getRosterFromFirebase() async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('rosters')
        .get();
    List<Roster> team = qs.docs
        .map((doc) => Roster.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return team;
  }
}
