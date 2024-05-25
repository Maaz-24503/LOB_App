import 'package:firebase_auth/firebase_auth.dart';
import 'package:lob_app/models/user.dart';
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
    String? email = FirebaseAuth.instance.currentUser!.email;

    return _authRepo.getUserFromFireBase(email: email);
  }

  Future<Users> loginWithGoogle() async {
    return _authRepo.firebaseGoogleLogin();
  }

  Future<void> editName({String? firstName, String? lastName}) async {
    await _authRepo.updateName();
  }

  Future<void> singupWithFirebase({String? email, String? password}) async {
    await _authRepo.firebaseSignup(email: email, password: password);
  }

  Future<void> logout() async {
    await _authRepo.firebaseLogout();
  }
}
