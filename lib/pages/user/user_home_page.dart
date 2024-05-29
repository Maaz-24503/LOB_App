import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/my_drawer.dart';
import 'package:lob_app/pages/user/ranks_page.dart';
import 'package:lob_app/pages/user/schedule_page.dart';
import 'package:lob_app/pages/user/teams_page.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Durations.extralong1,
      length: 3,
      child: SafeArea(
        child: Scaffold(
            drawer: const MyDrawer(),
            appBar: AppBar(
              foregroundColor: LOBColors.backGround,
              centerTitle: true,
              title: const Text(
                "Home Page",
              ),
              backgroundColor: LOBColors.primary,
              bottom: const TabBar(
                labelStyle: TextStyle(color: LOBColors.backGround),
                tabs: [
                  Tab(icon: Icon(Icons.group), text: "Teams"),
                  Tab(
                      icon: Icon(Icons.arrow_upward_outlined),
                      text: "Standings"),
                  Tab(icon: Icon(Icons.av_timer_rounded), text: 'Schedule')
                ],
              ),
            ),
            body: const TabBarView(
              children: [TeamsPage(), RanksPage(), SchedulePage()],
            )),
      ),
    );
  }
}
