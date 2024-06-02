import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/user/game_card.dart';
import 'package:lob_app/models/schedule.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/providers/teams_provider.dart';

class SeasonGamesPage extends ConsumerWidget {
  final GamesSchedule season;
  const SeasonGamesPage({super.key, required this.season});

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
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Season ${season.season}',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
              ),
              backgroundColor: LOBColors.primary,
              foregroundColor: LOBColors.backGround,
            ),
            body: prov.when(
              data: (value) => FutureBuilder(
                future: getImages(value, context),
                builder: (context, snapshot) {
                  return season.games.isNotEmpty?ListView.builder(
                      itemCount: season.games.length,
                      itemBuilder: (ctx, idx) => GameCard(
                            game: season.games[idx],
                            season: idx+1,
                          )):const Center(child: Text("No games played so far"));
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text(err.toString())),
            )));
  }
}
