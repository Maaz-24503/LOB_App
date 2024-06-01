import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/components/admin/admin_button.dart';
import 'package:lob_app/components/admin/admin_text_field.dart';
import 'package:lob_app/models/schedule.dart';
import 'package:lob_app/pages/loading_page.dart';
import 'package:lob_app/providers/schedule_provider.dart';
import 'package:lob_app/providers/standings_provider.dart';
import 'package:lob_app/providers/teams_provider.dart';
import 'package:lob_app/common/colors.dart';

final dateTimeProvider = StateProvider<DateTime?>((ref) => null);

class AddGameForm extends ConsumerWidget {
  final int season;
  AddGameForm({super.key, required this.season});

  final TextEditingController team1Controller = TextEditingController();
  final TextEditingController team2Controller = TextEditingController();

  final Map<int, String> months = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
  };

  void _showTranslucentPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => const TranslucentPage(),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context, WidgetRef ref) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: LOBColors.secondary, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: LOBColors.secondary, // body text color
            ),
            dialogBackgroundColor:
                Colors.white, // background color of the dialog
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 243, 173, 173),
                onSurface: Color.fromARGB(255, 88, 19, 19),
              ),
              timePickerTheme: const TimePickerThemeData(
                dialHandColor: LOBColors.secondary, // clock dial hand color
                hourMinuteTextColor:
                    LOBColors.secondary, // hour and minute text color
              ),
            ),
            child: child!,
          );
        },
      );

      if (selectedTime != null) {
        final DateTime selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        ref.read(dateTimeProvider.notifier).state = selectedDateTime;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.read(teamsProvider);
    final selectedDateTime = ref.watch(dateTimeProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 35.0, left: 8, right: 8, bottom: 8),
              child: AdminTextField(
                  controller: team1Controller,
                  hintText: "Team 1 Name",
                  hide: false),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AdminTextField(
                  controller: team2Controller,
                  hintText: "Team 2 Name",
                  hide: false),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => _selectDateTime(context, ref),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: LOBColors.secondary,
                        backgroundColor: Colors.white // button color
                        ),
                    child: const Text("Select Date & Time"),
                  ),
                  if (selectedDateTime != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Selected: ${selectedDateTime.toLocal().day.toString().padLeft(2, '0')}, ${months[selectedDateTime.toLocal().month]}, ${selectedDateTime.toLocal().year}, ${selectedDateTime.toLocal().hour.toString().padLeft(2, '0')}:${selectedDateTime.toLocal().minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: LOBColors.secondary),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AdminButton(
                text: "Submit",
                onPressed: () async {
                  if (team1Controller.text.isNotEmpty &&
                      team2Controller.text.isNotEmpty &&
                      selectedDateTime != null) {
                    _showTranslucentPage(context);
                    await ref.watch(gamesProvider.notifier).addGame(
                        Game(
                            team1: team1Controller.text,
                            team2: team2Controller.text,
                            time: Timestamp.fromDate(selectedDateTime)),
                        season);
                    await ref
                        .read(seasonsProvider.notifier)
                        .updateStandings(season);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Incomplete Form"),
                          content: const Text(
                              "Please fill all fields and select a date and time."),
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
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
            ),
          ],
        ),
      ),
    );
  }
}
