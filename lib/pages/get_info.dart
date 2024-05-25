import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/auth_button.dart';
import 'package:lob_app/components/text_field.dart';
import 'package:lob_app/models/user.dart';
import 'package:lob_app/pages/admin_home_page.dart';
import 'package:lob_app/pages/user_home_page.dart';
import 'package:lob_app/providers/user_provider.dart';

class InfoPage extends StatelessWidget {
  InfoPage({super.key});
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final UserService _userService = UserService();
  void handlePressed(context) async {
    if (firstNameController.text != "" && lastNameController.text != "") {
      try {
        await _userService.editName(
            firstName: firstNameController.text,
            lastName: lastNameController.text);
        final Users currUser = await _userService.getUser();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => (currUser.role == Role.user)
                    ? UserHomePage()
                    : const AdminHomePage()),
            (route) => false);
      } on FirebaseAuthException catch (error) {
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
