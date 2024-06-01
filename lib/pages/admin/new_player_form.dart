import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/admin/admin_button.dart';
import 'package:lob_app/components/admin/admin_text_field.dart';
import 'package:lob_app/models/player.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/pages/loading_page.dart';
import 'package:lob_app/providers/teams_provider.dart';

class NewPlayerForm extends ConsumerWidget {
  final Team team;
  NewPlayerForm({super.key, required this.team});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController jerseyController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

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
                    height: 50,
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
                              controller: firstNameController,
                              hintText: "First Name",
                              hide: false),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: AdminTextField(
                              controller: lastNameController,
                              hintText: "Last Name",
                              hide: false),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AdminTextField(
                              controller: ageController,
                              hintText: "Age",
                              hide: false),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AdminTextField(
                              controller: heightController,
                              hintText: "Height in meters",
                              hide: false),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AdminTextField(
                              controller: jerseyController,
                              hintText: "Jersey Number",
                              hide: false),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AdminButton(
                              text: "Create Player",
                              onPressed: () async {
                                if (firstNameController.text != "" &&
                                    heightController.text != "" &&
                                    jerseyController.text != "" &&
                                    ageController.text != "") {
                                  int? jerseyNumber =
                                      int.tryParse(jerseyController.text);

                                  if (jerseyNumber != null) {
                                    Player toBeAdded = Player(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        height: heightController.text,
                                        jerseyNumber: jerseyNumber,
                                        age: ageController.text);

                                    // ignore: use_build_context_synchronously
                                    _showTranslucentPage(context);
                                    await ref
                                        .read(rostersProvider.notifier)
                                        .addPlayer(toBeAdded, team.name);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Invalid Input"),
                                          content: const Text(
                                              "Please enter a valid jersey number"),
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
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Fill Form"),
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
