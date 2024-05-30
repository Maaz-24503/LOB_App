import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/auth_button.dart';
import 'package:lob_app/components/text_field.dart';
import 'package:lob_app/models/user.dart';
import 'package:lob_app/pages/decision_page.dart';
import 'package:lob_app/pages/user/get_info.dart';
import 'package:lob_app/pages/signup.dart';
import 'package:lob_app/pages/user/user_home_page.dart';
import 'package:lob_app/providers/user_provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _userService = UserService();
  void loginPressed(context) async {
    try {
      final Users currUser = await _userService.login(
          email: emailController.text, password: passwordController.text);
      if (currUser.firstName == '') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoPage()));
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const DecisionPage()),
            (route) => false);
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Center(
              child: Text(error.code),
            ),
            duration: const Duration(seconds: 2)),
      );
    }
  }

  void googleLogin(context) async {
    try {
      final Users currUser = await UserService().loginWithGoogle();
      if (currUser.firstName == '') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoPage()));
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const UserHomePage()),
            (route) => false);
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Center(
              child: Text('Could not Login through Google $error'),
            ),
            duration: const Duration(seconds: 4)),
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
                  "Login",
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
                const SizedBox(
                  height: 25,
                ),
                AuthButton(
                    text: 'Login', onPressed: () => loginPressed(context)),
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 26),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    const Text("Dont have an account?"),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: const Text(
                        " Sign up",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () => googleLogin(context),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    child: Image.asset(
                      'lib/pics/google.png',
                      height: 30,
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
