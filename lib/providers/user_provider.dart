import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lob_app/models/user.dart';
import 'package:lob_app/pages/login.dart';
import 'package:lob_app/repositories/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
Future<Users> user(UserRef ref) {
  return UserService().getUser();
}

class UserService {
  UserService._internal(); // Private constructor for singleton behavior

  static final UserService _instance =
      UserService._internal(); // Singleton instance

  factory UserService() {
    return _instance;
  }
  final AuthRepo _authRepo = AuthRepo();
  Future<Users> login({String? email, String? password}) async {
    await _authRepo.firebaseLogin(email: email, password: password);
    return getUser();
  }

  Future<Users> getUser() async {
    String? email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) {
      return Users(email: "", firstName: "", lastName: "", role: Role.user);
    }
    return _authRepo.getUserFromFireBase(email: email);
  }

  Future<Users> loginWithGoogle() async {
    return _authRepo.firebaseGoogleLogin();
  }

  Future<void> editName({String? firstName, String? lastName}) async {
    await _authRepo.updateName(firstName: firstName, lastName: lastName);
  }

  Future<void> signup({String? email, String? password}) async {
    await _authRepo.firebaseSignup(email: email, password: password);
  }

  Future<void> logout(context) async {
    await _authRepo.firebaseLogout();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }
}
