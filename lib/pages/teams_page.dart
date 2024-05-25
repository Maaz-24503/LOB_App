import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/pages/roster_page.dart';
import 'package:lob_app/providers/teams_provider.dart';

class TeamsPage extends ConsumerWidget {
  const TeamsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Team>> prov = ref.watch(teamsProvider);

    return SafeArea(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: prov.when(
            data: (value) => 10,
            error: (err, stack) => 0,
            loading: () => 0), // Number of items in the grid
        itemBuilder: (BuildContext context, int index) {
          return prov.when(
              data: (value) => Padding(
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
                                              team: value[index],
                                            )));
                              },
                              child: Hero(
                                tag: value[index].namedLogo!,
                                child: CachedNetworkImage(
                                  // progressIndicatorBuilder: (context, url, progress) =>
                                  //     Center(
                                  //   child: CircularProgressIndicator(
                                  //     value: progress.progress,
                                  //   ),
                                  // ),
                                  imageUrl: value[index].namedLogo!,
                                  placeholder: (context, url) => const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                              ))),
                    ),
                  ),
              error: (err, stack) => const Scaffold(
                  body: Center(
                      child: Text('Oops, something unexpected happened'))),
              loading: () => const Center(
                  child:
                      CircularProgressIndicator())); // Number of items in the grid
        },
      ),
    );
  }
}
