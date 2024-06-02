import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/common/helper.dart';
import 'package:lob_app/models/player.dart';
import 'package:lob_app/pages/loading_page.dart';
import 'package:lob_app/providers/teams_provider.dart';

class DeletePlayerSheet extends ConsumerWidget {
  final String team;
  final Player player;

  final _helper = Helper();

  DeletePlayerSheet({super.key, required this.team, required this.player});

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Delete Player",
                ),
                content: Text(
                    "Are you sure you want to remove ${player.firstName} as a player of $team. This action cannot be reverted?"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      _showTranslucentPage(context);
                      await _helper.executeWithInternetCheck(context, () async {
                        await ref
                            .read(rostersProvider.notifier)
                            .removePlayer(player, team);
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
                    'Remove ${player.firstName}',
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
