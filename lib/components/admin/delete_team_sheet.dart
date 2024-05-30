import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/providers/teams_provider.dart';

class DeleteTeamSheet extends ConsumerWidget {
  final Team team;
  const DeleteTeamSheet({super.key, required this.team});

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
                  "Delete Team",
                ),
                content: Text(
                    "Are you sure you want to remove team ${team.name}. This action cannot be reverted?"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await ref.read(teamsProvider.notifier).removeTeam(team);
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
                Text(
                  'Remove team ${team.name}',
                  style: const TextStyle(
                    fontSize: 17,
                    color: LOBColors.backGround,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.delete,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
