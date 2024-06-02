import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/common/helper.dart';
import 'package:lob_app/models/schedule.dart';
import 'package:lob_app/pages/loading_page.dart';
import 'package:lob_app/providers/schedule_provider.dart';
import 'package:lob_app/providers/standings_provider.dart';

class DeleteGameSheet extends ConsumerWidget {
  final Game game;
  final int season;
  DeleteGameSheet({super.key, required this.game, required this.season});

  void _showTranslucentPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => const TranslucentPage(),
      ),
    );
  }

  final _helper = Helper();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Delete Game",
                ),
                content: Text(
                    "Are you sure you want to remove ${game.team1} vs ${game.team2}. This action cannot be reverted?"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      _showTranslucentPage(context);
                      await _helper.executeWithInternetCheck(context, () async {
                        await ref
                            .read(gamesProvider.notifier)
                            .removeGame(game, season);
                        await ref
                            .read(seasonsProvider.notifier)
                            .updateStandings(season);
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: LOBColors.secondary),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
            border: Border.all(color: Colors.red),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 5,
                  child: Text(
                    'Remove ${game.team1} vs ${game.team2}',
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 17,
                      color: LOBColors.backGround,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
