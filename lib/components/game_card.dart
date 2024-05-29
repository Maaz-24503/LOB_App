import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/models/schedule.dart';

class GameCard extends StatelessWidget {
  final Map<String, Image>? images;
  final Game game;

  GameCard({super.key, this.images, required this.game});

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
  Widget build(BuildContext context) {
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
          color: LOBColors.backGround,
          border: Border.all(
            color: isPastGame ? LOBColors.primary : Colors.green,
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
                              backgroundColor: LOBColors.backGround,
                              child: images?[game.team1] ??
                                  const CircularProgressIndicator()),
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
                              backgroundColor: LOBColors.backGround,
                              child: images?[game.team2] ??
                                  const CircularProgressIndicator()),
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
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
