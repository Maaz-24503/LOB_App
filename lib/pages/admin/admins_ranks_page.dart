import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/models/standings.dart';
import 'package:lob_app/pages/admin/admins_seasons_page.dart';
import 'package:lob_app/providers/standings_provider.dart';

class AdminsRanksPage extends ConsumerWidget {
  const AdminsRanksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Season> prov = ref.watch(seasonsProvider);
    return SafeArea(
      child: Scaffold(
        body: prov.when(
          data: (value) => AdminsSeasonsPage(
            seasons: value,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text(err.toString())),
        ),
      ),
    );
  }
}
