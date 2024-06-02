import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/common/helper.dart';
import 'package:lob_app/models/schedule.dart';
import 'package:lob_app/pages/admin/admin_games_page.dart';
import 'package:lob_app/pages/loading_page.dart';
import 'package:lob_app/providers/schedule_provider.dart';
import 'package:lob_app/providers/standings_provider.dart';

class AdminSeasonTiles extends ConsumerWidget {
  final GamesSchedule season;
  final int latestSeason;
  AdminSeasonTiles(
      {super.key, required this.season, required this.latestSeason});

  void _showTranslucentPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => const TranslucentPage(),
      ),
    );
  }

  final _helper = Helper();

  Future<bool?> _showDeleteConfirmationDialog(
      BuildContext context, WidgetRef ref) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Season ${season.season}'),
          content: const Text(
              'Are you sure you want to delete this season? This will result in permanant loss of all records linked to it '),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                _showTranslucentPage(context);
                await _helper.executeWithInternetCheck(context, () async {
                  await ref.read(seasonsProvider.notifier).deleteLatestSeason();
                  await ref.read(gamesProvider.notifier).removeLatestSeason();
                });
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSeasonTile(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: LOBColors.secondaryBackGround,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminGamesPage(season: season),
            ),
          );
        },
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          tileColor: LOBColors.secondaryBackGround,
          leading: CircleAvatar(
            backgroundColor: LOBColors.secondary,
            child: Text(
              '${season.season}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: LOBColors.secondaryBackGround,
              ),
            ),
          ),
          title: Text('Season ${season.season}'),
          subtitle: const Text('Tap to see game details'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: season.season == latestSeason
          ? Dismissible(
              key: Key(season.season.toString()),
              direction: DismissDirection.startToEnd,
              background: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              confirmDismiss: (direction) async {
                return await _showDeleteConfirmationDialog(context, ref);
              },
              child: _buildSeasonTile(context),
            )
          : _buildSeasonTile(context),
    );
  }
}
