import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/models/roster.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/models/user.dart';
import 'package:lob_app/providers/teams_provider.dart';
import 'package:lob_app/providers/user_provider.dart';

class RosterPage extends ConsumerStatefulWidget {
  final Team team;

  const RosterPage({super.key, required this.team});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

// Notice how instead of "State", we are extending "ConsumerState".
// This uses the same principle as "ConsumerWidget" vs "StatelessWidget".
class _HomeState extends ConsumerState<RosterPage> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(rosterProvider, (previous, next) {
      // TODO show a snackbar/dialog
    });
  }

  @override
  Widget build(BuildContext context) {
    // "ref" is not passed as parameter anymore, but is instead a property of "ConsumerState".
    // We can therefore keep using "ref.watch" inside "build".
    final AsyncValue<Roster> activity = ref.watch(rosterProvider);

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
                            topRight: Radius.circular(20)),
                        color: LOBColors.backGround,
                      ),
                      child: activity.when(
                        data: (value) => ListView(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Name",
                                style: TextStyle(color: Color(0xFF79878F)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Height",
                                  style: TextStyle(color: Color(0xFF79878F))),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Weight",
                                  style: TextStyle(color: Color(0xFF79878F))),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Spawn",
                                  style: TextStyle(color: Color(0xFF79878F))),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Weakness",
                                  style: TextStyle(color: Color(0xFF79878F))),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Pre Evolution",
                                  style: TextStyle(color: Color(0xFF79878F))),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Next Evolution",
                                  style: TextStyle(color: Color(0xFF79878F))),
                            ),
                          ],
                        ),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (err, stack) =>
                            Center(child: Text(err.toString())),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.5 - 100,
                    top: MediaQuery.of(context).size.width * 0.5 - 100),
                child: SizedBox(
                    height: 220,
                    child: Hero(
                      tag: widget.team.namedLogo!,
                      child: CachedNetworkImage(
                        imageUrl: widget.team.namedLogo!,
                        placeholder: (context, url) => const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) {
                          print(error.toString());
                          return const Icon(Icons.error);
                        },
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
