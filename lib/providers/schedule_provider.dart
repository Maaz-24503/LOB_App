import 'package:lob_app/models/schedule.dart';
import 'package:lob_app/repositories/schedule_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_provider.g.dart';

@riverpod
class Games extends _$Games {
  @override
  Future<List<GamesSchedule>> build() async => ScheduleService().getAllGames();
  Future<void> addGame(Game game, int season) async {
    await ScheduleService().createGame(game, season);
    final previousState = await future;

    for (var szn in previousState) {
      if (szn.season == season) {
        szn.games.add(game);
      }
    }
    // Manually notify listeners.
    ref.notifyListeners();
  }

  Future<void> editScore(
      Game game, int season, int team1Score, int team2Score) async {
    await ScheduleService().scoreEdit(game, season, team1Score, team2Score);
    final previousState = await future;
    for (int i = 0; i < previousState.length; i++) {
      if (previousState[i].season == season) {
        // previousState[i].games.remove(game);
        for (int j = 0; j < previousState[i].games.length; j++) {
          if (game == previousState[i].games[j]) {
            previousState[i].games[j] = Game.fromJson({
              ...previousState[i].games[j].toJson(),
              "team1Score": team1Score,
              "team2Score": team2Score,
            });
            // print(previousState[i].games[j].toString());
            // Manually notify listeners.
            ref.notifyListeners();
            break;
          }
        }
      }
    }
  }

  Future<void> removeGame(Game game, int season) async {
    await ScheduleService().deleteGame(game, season);
    final previousState = await future;
    for (int i = 0; i < previousState.length; i++) {
      if (previousState[i].season == season) {
        var tba = {"season": season, "games": []};
        for (int j = 0; j < previousState[i].games.length; j++) {
          if (game == previousState[i].games[j]) {
            // Manually notify listeners.
          } else {
            (tba["games"] as List).add(previousState[i].games[j].toJson());
          }
        }
        previousState[i] = GamesSchedule.fromJson(tba);
        print(previousState[i].games.length);
      }
    }
    ref.notifyListeners();
  }

  Future<void> addSeason() async {
    await ScheduleService().createSeason();
    final prev = await future;
    prev.add(GamesSchedule(season: prev.length + 1, games: []));
    ref.notifyListeners();
  }

  Future<void> removeLatestSeason() async {
    await ScheduleService().removeSeason();
    final prev = await future;
    if (prev.isNotEmpty) {
      prev.removeLast();
    }
    ref.notifyListeners();
  }
}

class ScheduleService {
  final ScheduleRepo _scheduleRepo = ScheduleRepo();
  ScheduleService._internal(); // Private constructor for singleton behavior

  static final ScheduleService _instance =
      ScheduleService._internal(); // Singleton instance

  factory ScheduleService() {
    return _instance;
  }

  Future<List<GamesSchedule>> getAllGames() async {
    return _scheduleRepo.getScheduleFromFirebase();
  }

  Future<void> createGame(Game game, int season) async {
    await _scheduleRepo.addGameToFireBase(game, season);
  }

  Future<void> scoreEdit(
      Game game, int season, int team1Score, int team2Score) async {
    await _scheduleRepo.updateScoreToFireBase(
        game, season, team1Score, team2Score);
  }

  Future<void> deleteGame(Game game, int season) async {
    await _scheduleRepo.deleteGameFromFirebase(game, season);
  }

  Future<void> createSeason() async {
    await _scheduleRepo.addSeasonToFirebase();
  }

  Future<void> removeSeason() async {
    await _scheduleRepo.removeSeasonFromFirebase();
  }
}
