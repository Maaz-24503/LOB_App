import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/pages/user/roster_page.dart';
import 'package:lob_app/providers/logos_provider.dart';

class TeamCard extends ConsumerWidget {
  final Team team;

  const TeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoProv = ref.watch(logosProvider);
    return Padding(
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
            gradient: LOBColors.cardBackground,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              // side: const BorderSide(
              //   color: LOBColors.primary,
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
