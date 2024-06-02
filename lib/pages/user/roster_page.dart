import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/user/player_card.dart';
import 'package:lob_app/models/roster.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/providers/teams_provider.dart';

class RosterPage extends ConsumerStatefulWidget {
  final Team team;

  const RosterPage({super.key, required this.team});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<RosterPage> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(rostersProvider, (previous, next) {
    });
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Roster>> activity = ref.watch(rostersProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: LOBColors.backGround,
          title: Text(
            widget.team.name,
          ),
          backgroundColor: LOBColors.primary,
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
                      color: LOBColors.backGround,
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
                          itemCount: roster.players.length,
                          itemBuilder: (context, index) {
                            final player = roster.players[index];
                            return PlayerCard(player: player);
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
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
