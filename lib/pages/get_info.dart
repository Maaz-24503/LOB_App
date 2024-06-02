import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/common/helper.dart';
import 'package:lob_app/components/auth_button.dart';
import 'package:lob_app/components/text_field.dart';
import 'package:lob_app/models/user.dart';
import 'package:lob_app/pages/admin/admin_home_page.dart';
import 'package:lob_app/pages/loading_page.dart';
import 'package:lob_app/pages/user/user_home_page.dart';
import 'package:lob_app/providers/user_provider.dart';

class InfoPage extends StatelessWidget {
  InfoPage({super.key});
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final UserService _userService = UserService();
  final _helper = Helper();
  void _showTranslucentPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => const TranslucentPage(),
      ),
    );
  }

  void handlePressed(context) async {
    if (firstNameController.text != "" && lastNameController.text != "") {
      try {
        _showTranslucentPage(context);
        final Users currUser =
            await _helper.executeWithInternetCheck(context, () async {
          await _userService.editName(
              firstName: firstNameController.text,
              lastName: lastNameController.text);
          return await _userService.getUser();
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => (currUser.role == Role.user)
                    ? const UserHomePage()
                    : const AdminHomePage()),
            (route) => false);
      } on FirebaseAuthException catch (error) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Center(
                child: Text('Could not create User $error'),
              ),
              duration: const Duration(seconds: 4)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Center(
              child: Text('Please enter info in fields'),
            ),
            duration: Duration(seconds: 2)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: LOBColors.backGround,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 25.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/pics/LOB_Logo.png',
                  height: 100,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
          MyTextField(
              controller: firstNameController,
              hintText: "First-name",
              hide: false),
          MyTextField(
              controller: lastNameController,
              hintText: "Last-name",
              hide: false),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: AuthButton(
                text: "Confirm", onPressed: () => handlePressed(context)),
          )
        ],
      ),
    ));
  }
}
