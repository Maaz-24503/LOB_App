import 'dart:ui';

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
    return Scaffold(
      body: Stack(
        children: [
          // Blur background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                      gradient: LOBColors.formBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
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
                                  await ref
                                      .read(teamsProvider.notifier)
                                      .addTeam(toBeAdded);
                                  await ref.read(logosProvider.notifier).add(
                                      toBeAdded.name, toBeAdded.namedLogo!);
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
                                        content: const Text(
                                            "Please fill all the fields"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              "Okay",
                                              style: TextStyle(
                                                  color: LOBColors.secondary),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
