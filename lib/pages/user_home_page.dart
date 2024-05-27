import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/pages/ranks_page.dart';
import 'package:lob_app/pages/schedule_page.dart';
import 'package:lob_app/pages/teams_page.dart';
import 'package:lob_app/providers/user_provider.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = UserService();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Home Page",
              style: TextStyle(color: LOBColors.backGround),
            ),
            backgroundColor: LOBColors.primary,
            actions: [
              IconButton(
                  onPressed: () => userService.logout(context),
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: LOBColors.backGround,
                  ))
            ],
            bottom: const TabBar(
              labelStyle: TextStyle(color: LOBColors.backGround),
              tabs: [
                Tab(icon: Icon(Icons.group), text: "Teams"),
                Tab(icon: Icon(Icons.arrow_upward_outlined), text: "Standings"),
                Tab(icon: Icon(Icons.av_timer_rounded), text: 'Schedule')
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              TeamsPage(),
              RanksPage(),
              SchedulePage()
            ],
          )),
    );
  }
}
