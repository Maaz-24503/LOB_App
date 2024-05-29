import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lob_app/models/schedule.dart';

class ScheduleRepo {
  ScheduleRepo._internal(); // Private constructor for singleton behavior

  static final ScheduleRepo _instance =
      ScheduleRepo._internal(); // Singleton instance

  factory ScheduleRepo() {
    return _instance;
  }

  Future<List<GamesSchedule>> getScheduleFromFirebase() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('games').get();
    List<GamesSchedule> team = qs.docs.first['season']
        .map<GamesSchedule>(
            (doc) => GamesSchedule.fromJson(doc as Map<String, dynamic>))
        .toList();
    return team;
  }
}
