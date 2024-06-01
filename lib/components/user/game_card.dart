import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/models/schedule.dart';
import 'package:lob_app/providers/logos_provider.dart';

class GameCard extends ConsumerWidget {
  final Game game;
  final int season;
  GameCard({super.key, required this.game, required this.season});

  final Map<int, String> months = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Map<String, CachedNetworkImage>> prov = ref.watch(logosProvider);
    final now = DateTime.now();
    final gameTime = game.time.toDate();
    final isPastGame = gameTime.isBefore(now);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: Offset(0, 5),
            ),
          ],
          gradient: isPastGame
              ? LOBColors.gameOverBackground
              : LOBColors.yetToHappenBackground,
          border: Border.all(
            color: isPastGame ? LOBColors.gameOver : LOBColors.yetToHappen,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  '${gameTime.day}, ${months[gameTime.month]}, ${gameTime.year}, ${gameTime.hour.toString().padLeft(2, '0')}:${gameTime.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color.fromARGB(0, 231, 232, 255),
                              child: prov.when(
                                  data: (value) =>
                                      value[game.team1] ??
                                      const Icon(
                                        Icons.error,
                                      ),
                                  error: (error, temp) => const Icon(
                                        Icons.error,
                                      ),
                                  loading: () =>
                                      const CircularProgressIndicator(
                                        strokeWidth: 6,
                                        color: LOBColors.secondary,
                                      ))),
                          Text(game.team1),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color.fromARGB(0, 231, 232, 255),
                              child: prov.when(
                                  data: (value) =>
                                      value[game.team2] ??
                                      const Icon(
                                        Icons.error,
                                      ),
                                  error: (error, temp) => const Icon(
                                        Icons.error,
                                      ),
                                  loading: () =>
                                      const CircularProgressIndicator(
                                        strokeWidth: 6,
                                        color: LOBColors.secondary,
                                      ))),
                          Text(game.team2),
                        ],
                      ),
                    ),
                  ],
                ),
                if (game.team1Score != null && game.team2Score != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${game.team1Score}',
                            style: TextStyle(
                              fontSize: 22,
                                fontWeight: (game.team1Score ?? 0) >=
                                        (game.team2Score ?? 0)
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${game.team2Score}',
                            style: TextStyle(
                              fontSize: 22,
                                fontWeight: (game.team1Score ?? 0) <=
                                        (game.team2Score ?? 0)
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                Center(
                    child: Text(
                  'VS',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
