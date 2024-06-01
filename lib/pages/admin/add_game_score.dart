import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/models/schedule.dart';
import 'dart:ui';
import 'package:lob_app/pages/loading_page.dart';
import 'package:lob_app/providers/logos_provider.dart';
import 'package:lob_app/providers/schedule_provider.dart';
import 'package:lob_app/providers/standings_provider.dart';

class AddGameScore extends ConsumerWidget {
  final Game game;
  final int season;
  AddGameScore({super.key, required this.game, required this.season});

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

  final TextEditingController team1Score = TextEditingController();
  final TextEditingController team2Score = TextEditingController();

  void _showTranslucentPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => const TranslucentPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Map<String, CachedNetworkImage>> prov = ref.watch(logosProvider);

    final now = DateTime.now();
    final gameTime = game.time.toDate();
    final isPastGame = gameTime.isBefore(now);

    return Scaffold(
      body: Stack(
        children: [
          // Blur background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
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
                      color: isPastGame
                          ? LOBColors.gameOver
                          : LOBColors.yetToHappen,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
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
                                    child: Hero(
                                      tag: "${game.team1}, ${game.time}",
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
                                              )),
                                    )),
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
                                    child: Hero(
                                      tag: "${game.team2}, ${game.time}",
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
                                              )),
                                    )),
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
                                      fontWeight: (game.team1Score ?? 0) <=
                                              (game.team2Score ?? 0)
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: team1Score,
                        decoration: InputDecoration(
                          labelText: '${game.team1} Score',
                          labelStyle: const TextStyle(
                              color: Colors
                                  .white), // Set label text color to white
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: Colors
                                .white), // Set text color inside TextField to white
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: team2Score,
                        decoration: InputDecoration(
                          labelText: '${game.team2} Score',
                          labelStyle: const TextStyle(
                              color: Colors
                                  .white), // Set label text color to white
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: Colors
                                .white), // Set text color inside TextField to white
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor: WidgetStateProperty.all<Color>(
                              LOBColors.gameOver), // Text color
                          side: WidgetStateProperty.all<BorderSide>(
                            const BorderSide(
                                color: LOBColors.gameOver, width: 1),
                          ),
                        ),
                        onPressed: () async {
                          if (int.tryParse(team1Score.text) != null &&
                              int.tryParse(team2Score.text) != null) {
                            int t1Score = int.parse(team1Score.text);
                            int t2Score = int.parse(team2Score.text);
                            _showTranslucentPage(context);
                            await ref.read(gamesProvider.notifier).editScore(
                                game,
                                season,
                                int.parse(team1Score.text),
                                int.parse(team2Score.text));
                            await ref
                                .read(seasonsProvider.notifier)
                                .updateStandings(season);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Center(
                                    child: Text("Enter valid scores"),
                                  ),
                                  duration: Duration(seconds: 2)),
                            );
                          }
                        },
                        child: const Text('Update Score'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
