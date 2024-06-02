import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';

class GameKeeperPage extends StatefulWidget {
  const GameKeeperPage({super.key});

  @override
  GameKeeperPageState createState() => GameKeeperPageState();
}

class GameKeeperPageState extends State<GameKeeperPage> {
  TextEditingController team1Controller = TextEditingController();
  TextEditingController team2Controller = TextEditingController();

  int team1Score = 0;
  int team2Score = 0;

  Timer? shotClockTimer;
  Timer? quarterTimer;
  int shotClockSeconds = 24;
  int quarterSeconds = 600;
  int currentQuarter = 1;

  bool isRunning = false;

  @override
  void dispose() {
    shotClockTimer?.cancel();
    quarterTimer?.cancel();
    super.dispose();
  }

  void startTimers() {
    setState(() {
      isRunning = true;
    });
    shotClockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (shotClockSeconds > 0) {
        setState(() {
          shotClockSeconds--;
        });
      }
    });

    quarterTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (quarterSeconds > 0) {
          quarterSeconds--;
        } else {
          if (currentQuarter < 4) {
            currentQuarter++;
            quarterSeconds = 600;
            shotClockSeconds = 24;
          } else {
            quarterTimer?.cancel();
            shotClockTimer?.cancel();
            isRunning = false;
          }
        }
      });
    });
  }

  void pauseTimers() {
    setState(() {
      isRunning = false;
    });
    shotClockTimer?.cancel();
    quarterTimer?.cancel();
  }

  void resetShotClock() {
    setState(() {
      shotClockSeconds = 24;
    });
  }

  void resetQuarterClock() {
    setState(() {
      quarterSeconds = 600;
      shotClockSeconds = 24;
    });
  }

  void goToNextQuarter() {
    setState(() {
      currentQuarter = currentQuarter % 4 + 1;
      quarterSeconds = 600;
      shotClockSeconds = 24;
    });
  }

  void goToPreviousQuarter() {
    setState(() {
      currentQuarter = currentQuarter > 1 ? currentQuarter - 1 : 1;
      quarterSeconds = 600;
      shotClockSeconds = 24;
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void incrementTeam1Score() {
    setState(() {
      team1Score++;
    });
  }

  void incrementTeam2Score() {
    setState(() {
      team2Score++;
    });
  }

  void decrementTeam1Score() {
    setState(() {
      team1Score--;
    });
  }

  void decrementTeam2Score() {
    setState(() {
      team2Score--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: LOBColors.backGround,
      appBar: AppBar(
        foregroundColor: LOBColors.backGround,
        title: const Text(
          'Basketball Score Keeper',
        ),
        backgroundColor: LOBColors.primary,
      ),
      body: SingleChildScrollView(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(
                    orientation == Orientation.portrait ? 16.0 : 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: team1Controller,
                            decoration: const InputDecoration(
                              labelText: 'Team 1 Name',
                              labelStyle: TextStyle(color: LOBColors.primary),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: LOBColors.primary)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: LOBColors.primary)),
                            ),
                            style: const TextStyle(color: LOBColors.primary),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            controller: team2Controller,
                            decoration: const InputDecoration(
                              labelText: 'Team 2 Name',
                              labelStyle: TextStyle(color: LOBColors.primary),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: LOBColors.primary)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: LOBColors.primary)),
                            ),
                            style: const TextStyle(color: LOBColors.primary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${team1Controller.text}: $team1Score',
                                style: const TextStyle(
                                    fontSize: 24, color: LOBColors.primary),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  incrementTeam1Score();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder()),
                                child: const Text('+1'),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  if (team1Score > 0) decrementTeam1Score();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder()),
                                child: const Text('-1'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${team2Controller.text}: $team2Score',
                                style: const TextStyle(
                                    fontSize: 24, color: LOBColors.primary),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  incrementTeam2Score();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder()),
                                child: const Text('+1'),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  if (team2Score > 0) decrementTeam2Score();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder()),
                                child: const Text('-1'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 10,
                      children: [
                        ElevatedButton(
                          onPressed: goToPreviousQuarter,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: const Text('Previous Quarter'),
                        ),
                        ElevatedButton(
                          onPressed: goToNextQuarter,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: const Text('Next Quarter'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Quarter: $currentQuarter',
                      style: const TextStyle(
                          fontSize: 24, color: LOBColors.primary),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Quarter Clock: ${formatTime(quarterSeconds)}',
                      style: const TextStyle(
                          fontSize: 24, color: LOBColors.primary),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Shot Clock: ${shotClockSeconds}s',
                      style: const TextStyle(
                          fontSize: 24, color: LOBColors.primary),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: resetShotClock,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text('Reset Shot Clock'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Reset Quarter Clock"),
                              content: const Text(
                                  "Are you sure you want to reset the quarter clock?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    resetQuarterClock();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Reset"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text('Reset Quarter Clock'),
                    ),
                    ElevatedButton(
                      onPressed: isRunning ? pauseTimers : startTimers,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(isRunning ? 'Pause' : 'Start'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
