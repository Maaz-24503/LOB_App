import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/admin/admin_button.dart';
import 'package:lob_app/components/admin/admin_text_field.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/pages/loading_page.dart';
import 'package:lob_app/providers/logos_provider.dart';
import 'package:lob_app/providers/teams_provider.dart';

class NewTeamForm extends ConsumerWidget {
  NewTeamForm({super.key});

  final TextEditingController teamNameController = TextEditingController();

  final TextEditingController nameLessIconController = TextEditingController();

  final TextEditingController namedIconController = TextEditingController();

  void _showTranslucentPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => const TranslucentPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 35.0, left: 8, right: 8, bottom: 8),
              child: AdminTextField(
                  controller: teamNameController,
                  hintText: "Team Name",
                  hide: false),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AdminTextField(
                  controller: namedIconController,
                  hintText: "Team Logo with name",
                  hide: false),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AdminTextField(
                  controller: nameLessIconController,
                  hintText: "Team Logo without name",
                  hide: false),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AdminButton(
                  text: "Create Team",
                  onPressed: () async {
                    if (teamNameController.text != "" &&
                        nameLessIconController.text != "" &&
                        namedIconController.text != "") {
                      Team toBeAdded = Team.fromJson({
                        "name": teamNameController.text,
                        "namelessLogo": nameLessIconController.text,
                        "namedLogo": namedIconController.text
                      });
                      // await prov.addTeam(toBeAdded);
                      // ignore: use_build_context_synchronously
                      _showTranslucentPage(context);
                      await ref.read(teamsProvider.notifier).addTeam(toBeAdded);
                      await ref
                          .read(logosProvider.notifier)
                          .add(toBeAdded.name, toBeAdded.namedLogo!);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              "Fill Form",
                            ),
                            content: const Text("Please fill all the fields"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Okay",
                                  style: TextStyle(color: LOBColors.secondary),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
            )
          ],
        ),
      ),
    );
  }
}
