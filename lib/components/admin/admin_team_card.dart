import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/models/team.dart';

class AdminTeamCard extends StatelessWidget {
  final Team team;
  const AdminTeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: LOBColors.secondary,
            width: 2.0,
          ), // Customize the border color and width
        ),
        color: LOBColors.secondaryBackGround,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => RosterPage(
              //               team: team,
              //             )));
            },
            child: Hero(
              tag: team.namedLogo!,
              child: CachedNetworkImage(
                imageUrl: team.namedLogo!,
                placeholder: (context, url) => const CircularProgressIndicator(
                  strokeWidth: 6,
                  color: LOBColors.secondary,
                ),
                errorWidget: (context, url, error) {
                  return const Icon(
                    Icons.error,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
