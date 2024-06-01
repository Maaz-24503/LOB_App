import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/pages/admin/new_player_form.dart';
import 'package:lob_app/models/team.dart';

class AdminAddPlayer extends StatelessWidget {
  final Team team;
  const AdminAddPlayer({super.key, required this.team});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewPlayerForm(team: team)));
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
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.add,
                    size: 50,
                    color: LOBColors.secondary,
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
