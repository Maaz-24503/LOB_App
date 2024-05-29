import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/models/standings.dart';
import 'package:lob_app/pages/admin/admin_season_details.dart';

class AdminsSeasonsPage extends StatelessWidget {
  final Season seasons;
  const AdminsSeasonsPage({super.key, required this.seasons});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: LOBColors.secondaryBackGround,
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
                      builder: (context) => AdminSeasonDetailsPage(
                        teams: seasons.seasons[index].teamStandings,
                        season: index + 1,
                      ),
                    ));
              },
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                tileColor: LOBColors.backGround,
                leading: CircleAvatar(
                  backgroundColor: LOBColors.secondary,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: LOBColors.backGround,
                    ),
                  ),
                ),
                title: Text('Season ${index + 1}'),
                subtitle: const Text('Tap to view standings'),
              ),
            ),
          )),
      itemCount: seasons.seasons.length,
    );
  }
}
