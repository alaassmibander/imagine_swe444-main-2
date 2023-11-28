import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //Google signin
  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from the request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //Sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
