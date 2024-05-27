import 'player.dart';

class Roster {
  final String teamName;
  final List<Player> players;

  Roster({required this.teamName, required this.players});

  factory Roster.fromJson(Map<String, dynamic> json) {
    return Roster(
      teamName: json['teamName'],
      players: (json['players'] as List<dynamic>)
          .map((playerJson) => Player.fromJson(playerJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'players': players.map((player) => player.toJson()).toList(),
    };
  }
}
