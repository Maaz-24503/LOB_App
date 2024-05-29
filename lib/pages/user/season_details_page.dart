import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/models/standings.dart';

class SeasonDetailsPage extends StatelessWidget {
  final List<TeamStanding> teams;
  final int season;
  const SeasonDetailsPage(
      {super.key, required this.teams, required this.season});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LOBColors.backGround,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Season $season"),
          backgroundColor: LOBColors.primary,
          foregroundColor: LOBColors.backGround,
        ),
        body: ListView(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Center(
                  child: Card(
                    color: Colors.white,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Team Standings',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataTable(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                    return LOBColors.primary;
                    // Use the default value.
                  }),
                  headingTextStyle:
                      const TextStyle(color: LOBColors.backGround),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Rank',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Team Name',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Games Won',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Games Lost',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Win/Loss Ratio',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: teams.asMap().entries.map((entry) {
                    int index = entry.key;
                    TeamStanding team = entry.value;
                    double winLossRatio = team.gamesWon /
                        (team.gamesLost != 0 ? team.gamesLost : 1);
                    return DataRow(cells: [
                      DataCell(Text(
                        '${index + 1}',
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      )), // Rank
                      DataCell(Text(
                        team.teamName,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      )),
                      DataCell(Text(
                        '${team.gamesWon}',
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      )),
                      DataCell(Text(
                        '${team.gamesLost}',
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      )),
                      DataCell(Text(
                        winLossRatio.toStringAsFixed(2),
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
