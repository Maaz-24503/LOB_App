import 'package:lob_app/models/player.dart';
import 'package:lob_app/models/roster.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/repositories/teams_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'teams_provider.g.dart';

@riverpod
class Teams extends _$Teams {
  @override
  Future<List<Team>> build() async => TeamService().getAllTeams();

  Future<void> addTeam(Team team) async {
    try {
      await TeamService().createTeam(
        name: team.name,
        nameLessLogo: team.namelessLogo,
        namedLogo: team.namedLogo,
      );
      final previousState = await future;
      // Mutable the previous list of todos.
      previousState.add(team);
      // Manually notify listeners.
      ref.notifyListeners();
    } catch (error) {
      // Handle error, e.g., print error message or show a snackbar to the user
      print("Error creating team: $error");
    }
  }

  Future<void> removeTeam(Team team) async {
    try {
      await TeamService().deleteTeam(team);
      final previousState = await future;
      // Mutable the previous list of todos.
      previousState.remove(team);
      // Manually notify listeners.
      ref.notifyListeners();
    } catch (err) {
      print(err);
    }
  }
}

@riverpod
class Rosters extends _$Rosters {
  Future<List<Roster>> build() async => TeamService().getRoster();

  Future<void> addPlayer(Player player, String teamName) async {
    await TeamService().addPlayer(player: player, teamName: teamName);
    final previousState = await future;
    for (var team in previousState) {
      if (team.teamName == teamName) {
        team.players.add(player);
      }
    }
    ref.notifyListeners();
  }

  Future<void> removePlayer(Player player, String teamName) async {
    await TeamService().deletePlayer(player: player, teamName: teamName);
    final previousState = await future;
    for (var team in previousState) {
      if (team.teamName == teamName) {
        team.players.remove(player);
      }
    }
    ref.notifyListeners();
  }
}

class TeamService {
  final TeamsRepo _teamsRepo = TeamsRepo();
  TeamService._internal(); // Private constructor for singleton behavior

  static final TeamService _instance =
      TeamService._internal(); // Singleton instance

  factory TeamService() {
    return _instance;
  }

  Future<List<Team>> getAllTeams() async {
    return await _teamsRepo.getTeamsFromFirebase();
  }

  Future<List<Roster>> getRoster() async {
    return await _teamsRepo.getRosterFromFirebase();
  }

  Future<void> createTeam(
      {String? name, String? nameLessLogo, String? namedLogo}) async {
    await _teamsRepo.createTeamInFirebase(
        name: name, nameLessLogo: nameLessLogo, namedLogo: namedLogo);
  }

  Future<void> deleteTeam(Team team) async {
    await _teamsRepo.removeTeamFromFirebase(team);
  }

  Future<void> addPlayer(
      {required Player player, required String teamName}) async {
    await _teamsRepo.addPlayerToFirebase(player: player, teamName: teamName);
  }

  Future<void> deletePlayer(
      {required Player player, required String teamName}) async {
    await _teamsRepo.removePlayerFromFirebase(
        player: player, teamName: teamName);
  }
}
