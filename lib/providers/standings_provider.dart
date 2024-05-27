import 'package:lob_app/models/standings.dart';
import 'package:lob_app/repositories/standings_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'standings_provider.g.dart';

@riverpod
Future<Season> seasons(SeasonsRef ref) {
  return StandingsService().getAllSeasons();
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
}
