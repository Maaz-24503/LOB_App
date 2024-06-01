import 'package:cloud_firestore/cloud_firestore.dart';

class GamesSchedule {
  final int season;
  final List<Game> games;

  GamesSchedule({required this.season, required this.games});

  factory GamesSchedule.fromJson(Map<String, dynamic> json) {
    var temp = GamesSchedule(
      season: json['season'],
      games:
          (json['games'] as List).map((game) => Game.fromJson(game)).toList(),
    );
    sortSeasonsByTime(temp);
    return temp;
  }

  Map<String, dynamic> toJson() {
    return {
      'season': season,
      'games': games.map((game) => game.toJson()).toList(),
    };
  }

  static void sortSeasonsByTime(GamesSchedule season) {
    season.games.sort((a, b) => b.time.compareTo(a.time));
  }
}

class Game {
  final String team1;
  final String team2;
  final Timestamp time;
  final int? team1Score;
  final int? team2Score;

  Game({
    required this.team1,
    required this.team2,
    required this.time,
    this.team1Score,
    this.team2Score,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      team1: json['team1'],
      team2: json['team2'],
      time: json['time'],
      team1Score: json['team1Score'],
      team2Score: json['team2Score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team1': team1,
      'team2': team2,
      'time': time,
      'team1Score': team1Score,
      'team2Score': team2Score,
    };
  }

  @override
  String toString() {
    return "$team1, $team2, $team1Score, $team2Score";
  }
}
