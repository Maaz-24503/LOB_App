import 'package:lob_app/models/standings.dart';
import 'package:lob_app/repositories/standings_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'standings_provider.g.dart';

@riverpod
class Seasons extends _$Seasons {
  Future<Season> build() async => StandingsService().getAllSeasons();
  Future<void> updateStandings(int season) async {
    await StandingsService().updateAllStandings(season);
  }

  Future<void> createSeason() async {
    await StandingsService().makeSeason();
    final prev = await future;
    prev.seasons.add(SeasonData(teamStandings: []));
    updateStandings(prev.seasons.length - 1);
    ref.notifyListeners();
  }

  Future<void> deleteLatestSeason() async {
    await StandingsService().deleteSeason();
    final prev = await future;
    if (prev.seasons.isNotEmpty) {
      prev.seasons.removeLast();
    }
    ref.notifyListeners();
  }
}

class StandingsService {
  final StandingsRepo _standingsRepo = StandingsRepo();
  StandingsService._internal(); // Private constructor for singleton behavior

  static final StandingsService _instance =
      StandingsService._internal(); // Singleton instance

  factory StandingsService() {
    return _instance;
  }

  Future<Season> getAllSeasons() async {
    return await _standingsRepo.getAllSeasonsFromFirebase();
  }

  Future<void> updateAllStandings(int season) async {
    await _standingsRepo.updateStandingsInFirebase(season);
  }

  Future<void> makeSeason() async {
    await _standingsRepo.createSeasonInFirebase();
  }

  Future<void> deleteSeason() async {
    await _standingsRepo.deleteLatestSeasonFromFireBase();
  }
}
