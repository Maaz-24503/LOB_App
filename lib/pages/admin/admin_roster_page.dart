import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/admin/admin_add_player.dart';
import 'package:lob_app/components/admin/admin_player_card.dart';
import 'package:lob_app/models/roster.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/providers/teams_provider.dart';

class AdminRosterPage extends ConsumerStatefulWidget {
  final Team team;

  const AdminRosterPage({super.key, required this.team});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<AdminRosterPage> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(rostersProvider, (previous, next) {});
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Roster>> activity = ref.watch(rostersProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: LOBColors.secondaryBackGround,
          title: Text(
            widget.team.name,
          ),
          backgroundColor: LOBColors.secondary,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: LOBColors.secondaryBackGround,
                    ),
                    child: activity.when(
                      data: (value) {
                        Roster roster =
                            Roster(teamName: widget.team.name, players: []);
                        for (var temp in value) {
                          if (temp.teamName == widget.team.name) {
                            roster = temp;
                            break;
                          }
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: roster.players.length + 1,
                          itemBuilder: (context, index) {
                            if (index < roster.players.length) {
                              final player = roster.players[index];
                              return AdminPlayerCard(player: player, team: roster.teamName,);
                            } else {
                              return AdminAddPlayer(team: widget.team,);
                            }
                          },
                        );
                      },
                      loading: () => const Center(
                          child: CircularProgressIndicator(
                        color: LOBColors.secondary,
                      )),
                      error: (err, stack) =>
                          Center(child: Text(err.toString())),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                    child: Hero(
                      tag: widget.team.namedLogo!,
                      child: CachedNetworkImage(
                        imageUrl: widget.team.namedLogo!,
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
                Expanded(
                  flex: 7,
                  child: Container(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
