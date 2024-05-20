import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lob_app/models/user.dart';

class AuthRepo {
  static Future<UserCredential> firebaseLogin(
      {String? email, String? password}) async {
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    return userCredential;
  }

  static Future<Users> getUserFromFireBase({String? email}) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (qs.docs.isNotEmpty) {
      Map<String, dynamic> json = qs.docs.first.data() as Map<String, dynamic>;
      return Users.fromJSON(json);
    } else {
      return Users(email: email!, firstName: "", lastName: "", role: Role.user);
    }
  }

  static Future<Users> firebaseGoogleLogin()async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return getUserFromFireBase(email: googleUser?.email);
  }
}
