import 'package:firebase_auth/firebase_auth.dart';
import 'package:lob_app/models/user.dart';
import 'package:lob_app/repositories/auth_repo.dart';

class AuthServices {
  static Future<Users> login({String? email, String? password}) async {
    await AuthRepo.firebaseLogin(email: email, password: password);
    return getUser(email: email);
  }

  static Future<Users> getUser({String? email}) async {
    return AuthRepo.getUserFromFireBase(email: email);
  }
  static Future<Users> loginWithGoogle() async{
    return AuthRepo.firebaseGoogleLogin();
  }
}
