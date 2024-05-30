import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/components/user/team_card.dart';
import 'package:lob_app/models/team.dart';
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
            data: (value) => value.length,
            error: (err, stack) => 0,
            loading: () => 0), // Number of items in the grid
        itemBuilder: (BuildContext context, int index) {
          return prov.when(
              data: (value) => TeamCard(team: value[index]),
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
