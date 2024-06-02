import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/common/helper.dart';
import 'package:lob_app/pages/loading_page.dart';
import 'package:lob_app/providers/schedule_provider.dart';
import 'package:lob_app/providers/standings_provider.dart';

class AddSeasonTile extends ConsumerWidget {
  AddSeasonTile({super.key});

  void _showTranslucentPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => const TranslucentPage(),
      ),
    );
  }

  final _helper = Helper();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      "Create New Season",
                    ),
                    content: const Text(
                        "Are you sure you want to create a new season"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          _showTranslucentPage(context);
                          await _helper.executeWithInternetCheck(context,
                              () async {
                            await ref
                                .read(seasonsProvider.notifier)
                                .createSeason();
                            await ref.read(gamesProvider.notifier).addSeason();
                          });
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Create",
                          style: TextStyle(color: LOBColors.secondary),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              tileColor: LOBColors.secondaryBackGround,
              leading: const CircleAvatar(
                  backgroundColor: LOBColors.secondary,
                  child: Icon(
                    Icons.add,
                    color: LOBColors.secondaryBackGround,
                  )),
              title: const Padding(
                padding: EdgeInsets.symmetric(vertical: 11.0),
                child: Text("Add New Season"),
              ),
            ),
          ),
        ));
  }
}
