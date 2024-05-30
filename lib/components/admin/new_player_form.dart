import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/admin/admin_button.dart';
import 'package:lob_app/components/admin/admin_text_field.dart';
import 'package:lob_app/models/player.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/providers/teams_provider.dart';

class NewPlayerForm extends ConsumerWidget {
  final Team team;
  NewPlayerForm({super.key, required this.team});

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController heightController = TextEditingController();

  final TextEditingController jerseyController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.read(rostersProvider);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: SingleChildScrollView(
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
                  controller: ageController, hintText: "Age", hide: false),
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
                      Player toBeAdded = Player(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          height: heightController.text,
                          jerseyNumber: int.parse(jerseyController.text),
                          age: ageController.text);
                      // await prov.addTeam(toBeAdded);
                      // ignore: use_build_context_synchronously
                      await ref
                          .read(rostersProvider.notifier)
                          .addPlayer(toBeAdded, team.name);
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
