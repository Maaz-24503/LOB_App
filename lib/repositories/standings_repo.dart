import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lob_app/models/standings.dart';

class StandingsRepo {
  StandingsRepo._internal(); // Private constructor for singleton behavior

  static final StandingsRepo _instance =
      StandingsRepo._internal(); // Singleton instance

  factory StandingsRepo() {
    return _instance;
  }

  Future<Season> getAllSeasonsFromFirebase() async {
    QuerySnapshot temp =
        await FirebaseFirestore.instance.collection('standings').get();
    return Season.fromJson(temp.docs.first.data() as Map<String, dynamic>);
  }
}
