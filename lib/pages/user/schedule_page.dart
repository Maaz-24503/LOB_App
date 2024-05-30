import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/components/user/season_tiles.dart';
import 'package:lob_app/models/schedule.dart';
import 'package:lob_app/providers/schedule_provider.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<GamesSchedule>> prov = ref.watch(gamesProvider);
    return prov.when(
      data: (value) => ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            return SeasonTiles(season: value[index]);
          }),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text(err.toString())),
    );
  }
}
