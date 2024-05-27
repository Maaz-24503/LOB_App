import 'dart:async';
import 'package:flutter/material.dart';

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
      setState(() {
        if (shotClockSeconds > 0) {
          shotClockSeconds--;
        } else {
          shotClockTimer?.cancel();
        }
      });
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

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Basketball Score Keeper',
              style: TextStyle(color: Colors.black, fontFamily: 'Sporty')),
          backgroundColor: Colors.yellow,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: team1Controller,
                  decoration: const InputDecoration(
                    labelText: 'Team 1 Name',
                    labelStyle: TextStyle(color: Colors.yellow),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                  ),
                  style: const TextStyle(
                      color: Colors.yellow, fontFamily: 'Sporty'),
                ),
                TextField(
                  controller: team2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Team 2 Name',
                    labelStyle: TextStyle(color: Colors.yellow),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                  ),
                  style: const TextStyle(
                      color: Colors.yellow, fontFamily: 'Sporty'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${team1Controller.text}: $team1Score',
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.yellow,
                          fontFamily: 'Sporty'),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          onPressed: () {
                            setState(() {
                              team1Score++;
                            });
                          },
                          child: const Text('+1',
                              style: TextStyle(color: Colors.black)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          onPressed: () {
                            setState(() {
                              if (team1Score > 0) team1Score--;
                            });
                          },
                          child: const Text('-1',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                    Text(
                      '${team2Controller.text}: $team2Score',
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.yellow,
                          fontFamily: 'Sporty'),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          onPressed: () {
                            setState(() {
                              team2Score++;
                            });
                          },
                          child: const Text('+1',
                              style: TextStyle(color: Colors.black)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          onPressed: () {
                            setState(() {
                              if (team2Score > 0) team2Score--;
                            });
                          },
                          child: const Text('-1',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Quarter: $currentQuarter',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24, color: Colors.yellow, fontFamily: 'Sporty'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Quarter Clock: ${formatTime(quarterSeconds)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24, color: Colors.yellow, fontFamily: 'Sporty'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Shot Clock: ${shotClockSeconds}s',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24, color: Colors.yellow, fontFamily: 'Sporty'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                  onPressed: resetShotClock,
                  child: const Text('Reset Shot Clock',
                      style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow),
                      onPressed: isRunning ? pauseTimers : startTimers,
                      child: Text(isRunning ? 'Pause' : 'Start',
                          style: const TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
