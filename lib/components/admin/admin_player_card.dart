import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/admin/delete_player_sheet.dart';
import 'package:lob_app/models/player.dart';

class AdminPlayerCard extends StatelessWidget {
  const AdminPlayerCard({super.key, required this.player, required this.team});
  final Player player;
  final String team;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showModalBottomSheet(
          backgroundColor: LOBColors.secondaryBackGround,
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DeletePlayerSheet(player: player, team: team,),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: LOBColors.secondary, width: 2.0),
          ),
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${player.firstName} ${player.lastName}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text('Age: ${player.age}'),
                Text('Height: ${player.height}'),
                Text('Jersey Number: ${player.jerseyNumber}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
