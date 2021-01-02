import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> handleSignInEmail(String email, String password) async {

    AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    return user;

  }

  Future<FirebaseUser> handleSignUp(email, password) async {

    AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert (user != null);
    assert (await user.getIdToken() != null);

    return user;

  }


  Future<void> signOut() async {
    await auth.signOut();
  }

}

