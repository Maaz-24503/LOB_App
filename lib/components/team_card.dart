import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/pages/roster_page.dart';

class TeamCard extends StatelessWidget {
  final Team team;

  const TeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: LOBColors.primary,
            width: 2.0,
          ), // Customize the border color and width
        ),
        color: LOBColors.backGround,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RosterPage(
                            team: team,
                          )));
            },
            child: Hero(
              tag: team.namedLogo!,
              child: CachedNetworkImage(
                imageUrl: team.namedLogo!,
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
