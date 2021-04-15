import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ifeeds/models/auth_response.dart';

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResponse> loginGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Credenciais para o Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      // Login no Firebase
      UserCredential result = await _auth.signInWithCredential(credential);
      final User? user = result.user;

      return AuthResponse.ok();
    } catch (e) {
      return AuthResponse.error(msg: "Oppss... não foi possível fazer o login");
    }
  }
}
