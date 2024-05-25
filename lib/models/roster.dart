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

class Player {
  final String firstName;
  final String lastName;
  final String age;
  final String height;

  Player({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.height,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      firstName: json['firstName'],
      lastName: json['lastName'],
      age: json['age'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'height': height,
    };
  }
}
