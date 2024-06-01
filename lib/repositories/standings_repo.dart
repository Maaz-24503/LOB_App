import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lob_app/models/schedule.dart';
import 'package:lob_app/models/standings.dart';
import 'package:lob_app/models/team.dart';

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

  Future<void> updateStandingsInFirebase(int season) async {
    try {
      // Fetch games
      QuerySnapshot qs =
          await FirebaseFirestore.instance.collection('games').get();
      List<GamesSchedule> allGames = qs.docs.first['season']
          .map<GamesSchedule>(
              (doc) => GamesSchedule.fromJson(doc as Map<String, dynamic>))
          .toList();

      // Fetch teams
      QuerySnapshot qs2 =
          await FirebaseFirestore.instance.collection('teams').get();
      List<Team> tmp = qs2.docs
          .map((doc) => Team.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Initialize teams map
      List<Map<String, dynamic>> teams = tmp
          .map<Map<String, dynamic>>(
              (item) => {"teamName": item.name, "gamesWon": 0, "gamesLost": 0})
          .toList();

      // Update teams with game results
      for (int i = 0; i < allGames.length; i++) {
        if (allGames[i].season == season) {
          for (int j = 0; j < allGames[i].games.length; j++) {
            if (allGames[i].games[j].team1Score != null &&
                allGames[i].games[j].team2Score != null) {
              if (allGames[i].games[j].team1Score! >
                  allGames[i].games[j].team2Score!) {
                for (int k = 0; k < teams.length; k++) {
                  if (teams[k]['teamName'] == allGames[i].games[j].team1) {
                    teams[k]['gamesWon']++;
                  }
                  if (teams[k]['teamName'] == allGames[i].games[j].team2) {
                    teams[k]['gamesLost']++;
                  }
                }
              }
              if (allGames[i].games[j].team1Score! <
                  allGames[i].games[j].team2Score!) {
                for (int k = 0; k < teams.length; k++) {
                  if (teams[k]['teamName'] == allGames[i].games[j].team1) {
                    teams[k]['gamesLost']++;
                  }
                  if (teams[k]['teamName'] == allGames[i].games[j].team2) {
                    teams[k]['gamesWon']++;
                  }
                }
              }
            }
          }
        }
      }

      // Fetch standings
      QuerySnapshot qs3 =
          await FirebaseFirestore.instance.collection('standings').get();

      // Create a copy of the standings data
      List<dynamic> updatedSeasonData = List.from(qs3.docs.first['Season']);

      // Update the copy with the new teams data
      updatedSeasonData[season - 1]['teams'] = teams;

      // Update Firestore with the modified data
      await qs3.docs.first.reference.update({"Season": updatedSeasonData});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createSeasonInFirebase() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('standings').get();

    List<dynamic> temp = qs.docs.first['Season'];
    temp.add({'teams': []});
    await qs.docs.first.reference.update({"Season": temp});
  }

  Future<void> deleteLatestSeasonFromFireBase() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('standings').get();
    List<dynamic> temp = qs.docs.first['Season'];
    if (temp.isNotEmpty) {
      temp.removeLast();
    }
    await qs.docs.first.reference.update({"Season": temp});
  }
}
