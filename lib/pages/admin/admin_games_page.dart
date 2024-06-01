import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/admin/add_game_card.dart';
import 'package:lob_app/components/admin/admin_game_card.dart';
import 'package:lob_app/models/schedule.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/providers/schedule_provider.dart';
import 'package:lob_app/providers/teams_provider.dart';

class AdminGamesPage extends ConsumerWidget {
  final GamesSchedule season;
  const AdminGamesPage({super.key, required this.season});

  Future<Map<String, Image>> getImages(
      List<Team> arr, BuildContext context) async {
    Map<String, Image> toBeReturned = {};
    for (var team in arr) {
      final image = Image.network(team.namedLogo!);
      await precacheImage(image.image, context);
      toBeReturned[team.name] = image;
    }
    return toBeReturned;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Team>> prov = ref.watch(teamsProvider);
    AsyncValue<List<GamesSchedule>> prov2 = ref.watch(gamesProvider);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Season ${season.season}',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
              ),
              backgroundColor: LOBColors.secondary,
              foregroundColor: LOBColors.backGround,
            ),
            body: prov.when(
              data: (value) => FutureBuilder(
                future: getImages(value, context),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: prov2.when(
                          data: (value) =>
                              value[season.season - 1].games.length + 1,
                          error: (error, stack) => 0,
                          loading: () => 0),
                      itemBuilder: (ctx, idx) => prov2.when(
                          data: (value) {
                            return (idx ==
                                    value[season.season - 1].games.length)
                                ? AddGameCard(season: season.season)
                                : AdminGameCard(
                                    game: value[season.season - 1].games[idx],
                                    season: season.season,
                                  );
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (err, stack) =>
                              Center(child: Text(err.toString()))));
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text(err.toString())),
            )));
  }
}
