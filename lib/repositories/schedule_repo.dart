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

  Future<void> addGameToFireBase(Game game, int season) async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('games').get();
    var tba = querySnapshot.docs.first['season'];
    for (int i = 0; i < tba.length; i++) {
      if (tba[i]['season'] == season) {
        tba[i]['games']
            .add({"team1": game.team1, "team2": game.team2, "time": game.time});
      }
    }
    await querySnapshot.docs.first.reference.update({"season": tba});
  }

  Future<void> deleteGameFromFirebase(Game game, int season) async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('games').get();
      var tba = querySnapshot.docs.first['season'];
      for (var i = 0; i < tba.length; i++) {
        if (tba[i]['season'] == season) {
          tba[i]['games'] = [];
          for (var j = 0;
              j < querySnapshot.docs.first['season'][i]['games'].length;
              j++) {
            if ((querySnapshot.docs.first['season'][i]['games'][j]['time']
                            as Timestamp)
                        .compareTo(game.time) ==
                    0 &&
                game.team1 ==
                    querySnapshot.docs.first['season'][i]['games'][j]
                        ['team1'] &&
                game.team2 ==
                    querySnapshot.docs.first['season'][i]['games'][j]
                        ['team2']) {
            } else {
              tba[i]['games']
                  .add(querySnapshot.docs.first['season'][i]['games'][j]);
            }
          }
        }
      }
      await querySnapshot.docs.first.reference.update({"season": tba});
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateScoreToFireBase(
      Game game, int season, int team1Score, int team2Score) async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('games').get();
      var tba = querySnapshot.docs.first['season'];
      for (var i = 0; i < tba.length; i++) {
        if (tba[i]['season'] == season) {
          for (var j = 0; j < tba[i]['games'].length; j++) {
            if ((tba[i]['games'][j]['time'] as Timestamp)
                        .compareTo(game.time) ==
                    0 &&
                game.team1 == tba[i]['games'][j]['team1'] &&
                game.team2 == tba[i]['games'][j]['team2']) {
              tba[i]['games'][j]['team1Score'] = team1Score;
              tba[i]['games'][j]['team2Score'] = team2Score;
            }
          }
        }
      }
      await querySnapshot.docs.first.reference.update({"season": tba});
    } catch (e) {
      print(e);
    }
  }

  Future<void> addSeasonToFirebase() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('games').get();

    Map<String, dynamic> temp = {"season": qs.docs.first['season']};
    temp["season"].add({"games": [], "season": temp['season'].length + 1});
    await qs.docs.first.reference.update(temp);
  }

  Future<void> removeSeasonFromFirebase() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('games').get();
    Map<String, dynamic> temp = {"season": qs.docs.first['season']};
    if (temp["season"].isNotEmpty) {
      temp["season"].removeLast();
    }
    await qs.docs.first.reference.update(temp);
  }
}
