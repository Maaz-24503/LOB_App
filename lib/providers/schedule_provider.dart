import 'package:lob_app/models/schedule.dart';
import 'package:lob_app/repositories/schedule_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_provider.g.dart';

@riverpod
Future<List<GamesSchedule>> games(GamesRef ref) {
  return ScheduleService().getAllGames();
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
}
