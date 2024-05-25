import 'package:lob_app/models/roster.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/repositories/teams_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'teams_provider.g.dart';

@riverpod
Future<List<Team>> teams(TeamsRef ref) {
  return TeamService().getAllTeams();
}

@riverpod
Future<Roster> roster(RosterRef ref) {
  return TeamService().getRoster();
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

  Future<Roster> getRoster({String? teamName}) async {
    return await _teamsRepo.getRosterFromFirebase(teamName: teamName);
  }
}
