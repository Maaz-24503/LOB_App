import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/models/standings.dart';
import 'package:lob_app/pages/seasons_page.dart';
import 'package:lob_app/providers/standings_provider.dart';

class RanksPage extends ConsumerWidget {
  const RanksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Season> prov = ref.watch(seasonsProvider);
    return SafeArea(
      child: Scaffold(
        body: prov.when(
          data: (value) => SeasonsPage(
            seasons: value,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text(err.toString())),
        ),
      ),
    );
  }
}
