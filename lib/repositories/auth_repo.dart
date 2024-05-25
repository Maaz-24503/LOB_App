import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lob_app/models/user.dart';

class AuthRepo {
  AuthRepo._internal(); // Private constructor for singleton behavior

  static final AuthRepo _instance = AuthRepo._internal(); // Singleton instance

  factory AuthRepo() {
    return _instance;
  }
  Future<UserCredential> firebaseLogin(
      {String? email, String? password}) async {
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    return userCredential;
  }

  Future<void> updateName({String? firstName, String? lastName}) async {
    final email = FirebaseAuth.instance.currentUser!.email;
    final query = FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email);
    final querySnapshot = await query.get();

    if (querySnapshot.docs.isNotEmpty) {
      final docRef = querySnapshot.docs.first.reference;
      // Update data in the document
      await docRef.update({
        'firstName': firstName,
        'lastName': lastName // Replace with your field name and new value
      });
    } else {
      // Handle case where no document is found
    }
  }

  Future<Users> getUserFromFireBase({String? email}) async {
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

  Future<Users> firebaseGoogleLogin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    Users temp = await getUserFromFireBase(email: googleUser?.email);
    if (temp.firstName == '') {
      Map<String, String?> user = {
        'email': FirebaseAuth.instance.currentUser!.email,
        'firstName': '',
        'lastName': '',
        'role': 'user' // Convert enum to string
      };
      await FirebaseFirestore.instance.collection('users').add(user);
    }
    return temp;
  }

  Future<void> firebaseSignup({String? email, String? password}) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    Map<String, String> user = {
      'email': email,
      'firstName': '',
      'lastName': '',
      'role': 'user' // Convert enum to string
    };
    await FirebaseFirestore.instance.collection('users').add(user);
  }

  Future<void> firebaseLogout() async {
    await FirebaseAuth.instance.signOut();
  }
}
