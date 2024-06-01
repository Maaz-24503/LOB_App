import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/auth_button.dart';
import 'package:lob_app/components/text_field.dart';
import 'package:lob_app/pages/get_info.dart';
import 'package:lob_app/pages/loading_page.dart';
import 'package:lob_app/providers/user_provider.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final UserService _userService = UserService();

  void _showTranslucentPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => const TranslucentPage(),
      ),
    );
  }

  void signUpPressed(context) async {
    if (passwordController.text == confirmController.text) {
      try {
        _showTranslucentPage(context);
        await _userService.signup(
            email: emailController.text, password: passwordController.text);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoPage()));
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
              child: Text('Passwords dont match'),
            ),
            duration: Duration(seconds: 4)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: LOBColors.backGround,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: (MediaQuery.of(context).size.height * 0.13)),
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
                const Text(
                  "Sign-up",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: LOBColors.primary),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hintText: 'Email',
                  hide: false,
                  controller: emailController,
                ),
                MyTextField(
                  hintText: 'Password',
                  hide: true,
                  controller: passwordController,
                ),
                MyTextField(
                  hintText: 'Confirm Password',
                  hide: true,
                  controller: confirmController,
                ),
                const SizedBox(
                  height: 25,
                ),
                AuthButton(
                    text: 'Sign up', onPressed: () => signUpPressed(context)),
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 26),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    const Text("Already have an account?"),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        " Log in",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          )),
    );
  }
}
