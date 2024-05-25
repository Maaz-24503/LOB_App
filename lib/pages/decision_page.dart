import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/models/user.dart';
import 'package:lob_app/pages/admin_home_page.dart';
import 'package:lob_app/pages/login.dart';
import 'package:lob_app/pages/user_home_page.dart';
import 'package:lob_app/providers/user_provider.dart';

class DecisionPage extends ConsumerWidget {
  const DecisionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Users> activity = ref.watch(userProvider);

    return activity.when(
      data: (value) {
        if (value.firstName == "") {
          return LoginPage();
        } else {
          return value.role == Role.user
              ? UserHomePage()
              : const AdminHomePage();
        }
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) =>
          Scaffold(body: Center(child: Text(err.toString()))),
    );
  }
}
