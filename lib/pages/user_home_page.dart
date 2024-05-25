import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/models/user.dart';
import 'package:lob_app/providers/user_provider.dart';

class UserHomePage extends ConsumerStatefulWidget {
  const UserHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

// Notice how instead of "State", we are extending "ConsumerState".
// This uses the same principle as "ConsumerWidget" vs "StatelessWidget".
class _HomeState extends ConsumerState<UserHomePage> {
  final UserService _userService = UserService();
  @override
  void initState() {
    super.initState();

    // State life-cycles have access to "ref" too.
    // This enables things such as adding a listener on a specific provider
    // to show dialogs/snackbars.
    ref.listenManual(userProvider, (previous, next) {
      // TODO show a snackbar/dialog
    });
  }

  @override
  Widget build(BuildContext context) {
    // "ref" is not passed as parameter anymore, but is instead a property of "ConsumerState".
    // We can therefore keep using "ref.watch" inside "build".
    final AsyncValue<Users> activity = ref.watch(userProvider);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Home Page",
            style: TextStyle(color: LOBColors.backGround),
          ),
          backgroundColor: LOBColors.primary,
          actions: [
            IconButton(
                onPressed: () => _userService.logout,
                icon: const Icon(Icons.abc))
          ],
        ),
        body: Center(
          child: switch (activity) {
            AsyncData(:final value) =>
              Center(child: Text('Activity: ${value.firstName}')),
            AsyncError() => const Text('Oops, something unexpected happened'),
            _ => const CircularProgressIndicator(),
          },
        ));
  }
}
