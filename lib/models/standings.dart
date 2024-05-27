class Season {
  final List<SeasonData> seasons;

  Season({required this.seasons});

  factory Season.fromJson(Map<String, dynamic> json) {
    Season temp = Season(
      seasons: (json['Season'] as List)
          .map((item) => SeasonData.fromJson(item))
          .toList(),
    );
    sortSeasonsByGamesWon(temp);
    return temp;
  }

  Map<String, dynamic> toJson() {
    return {
      'Season': seasons.map((item) => item.toJson()).toList(),
    };
  }

  static void sortSeasonsByGamesWon(Season season) {
    for (var seasonData in season.seasons) {
      seasonData.teamStandings.sort((a, b) => b.gamesWon.compareTo(a.gamesWon));
    }
  }
}

class SeasonData {
  final List<TeamStanding> teamStandings;

  SeasonData({required this.teamStandings});

  factory SeasonData.fromJson(Map<String, dynamic> json) {
    return SeasonData(
      teamStandings: (json['teams'] as List)
          .map((item) => TeamStanding.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teams': teamStandings.map((item) => item.toJson()).toList(),
    };
  }
}

class TeamStanding {
  final String teamName;
  final int gamesWon;
  final int gamesLost;

  TeamStanding({
    required this.teamName,
    required this.gamesWon,
    required this.gamesLost,
  });

  factory TeamStanding.fromJson(Map<String, dynamic> json) {
    return TeamStanding(
      teamName: json['teamName'] as String,
      gamesWon: json['gamesWon'] is String
          ? int.parse(json['gamesWon'])
          : json['gamesWon'],
      gamesLost: json['gamesLost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'gamesWon': gamesWon,
      'gamesLost': gamesLost,
    };
  }
}
