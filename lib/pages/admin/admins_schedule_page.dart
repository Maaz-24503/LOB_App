import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/admin/add_season_tile.dart';
import 'package:lob_app/components/admin/admin_season_tiles.dart';
import 'package:lob_app/models/schedule.dart';
import 'package:lob_app/providers/schedule_provider.dart';

class AdminsSchedulePage extends ConsumerWidget {
  const AdminsSchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<GamesSchedule>> prov = ref.watch(gamesProvider);
    return prov.when(
      data: (value) => ListView.builder(
          itemCount: value.length + 1,
          itemBuilder: (context, index) {
            return (index == value.length)
                ? AddSeasonTile()
                : AdminSeasonTiles(season: value[index], latestSeason: value.length);
          }),
      loading: () => const Center(
          child: CircularProgressIndicator(
        color: LOBColors.secondary,
      )),
      error: (err, stack) => Center(child: Text(err.toString())),
    );
  }
}
