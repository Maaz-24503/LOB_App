import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/admin/delete_team_sheet.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/pages/admin/admin_roster_page.dart';
import 'package:lob_app/providers/logos_provider.dart';
import 'package:lob_app/providers/schedule_provider.dart';

class AdminTeamCard extends ConsumerWidget {
  final Team team;
  const AdminTeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Map<String, CachedNetworkImage>> logoProv =
        ref.watch(logosProvider);
    ref.watch(gamesProvider);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onLongPress: () {
          showModalBottomSheet(
            backgroundColor: LOBColors.secondaryBackGround,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DeleteTeamSheet(team: team),
              );
            },
          );
        },
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminRosterPage(
                        team: team,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            gradient: LOBColors.adminCardBackground,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              // side: const BorderSide(
              //   color: LOBColors.secondary,
              //   width: 2.0,
              // ),
            ),
            color: Colors
                .transparent, // Make the Card transparent to show gradient
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Hero(
                tag: team.namedLogo!,
                child: logoProv.when(
                    data: (value) =>
                        value[team.name] ??
                        const Icon(
                          Icons.error,
                        ),
                    error: (error, temp) => const Icon(
                          Icons.error,
                        ),
                    loading: () => const CircularProgressIndicator(
                          strokeWidth: 6,
                          color: LOBColors.secondary,
                        )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
