import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/models/schedule.dart';
import 'package:lob_app/pages/user/season_games_page.dart';

class SeasonTiles extends StatelessWidget {
  final GamesSchedule season;
  const SeasonTiles({super.key, required this.season});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: LOBColors.backGround,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeasonGamesPage(season: season),
                  ));
            },
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              tileColor: LOBColors.backGround,
              leading: CircleAvatar(
                backgroundColor: LOBColors.primary,
                child: Text(
                  '${season.season}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: LOBColors.backGround,
                  ),
                ),
              ),
              title: Text('Season ${season.season}'),
              subtitle: const Text('Tap to see game details'),
            ),
          ),
        ));
  }
}
