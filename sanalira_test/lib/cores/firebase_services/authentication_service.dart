import 'package:firebase_auth/firebase_auth.dart';
import 'package:sanalira_test/models/firebase_models/user_local.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? activeUserId;

//UserLocal
  UserLocal? _createUser(User? user) {
    return user == null ? null : UserLocal.createUserByFirebase(user);
  }

  Stream<UserLocal?> get stateFollower {
    return _firebaseAuth.authStateChanges().map((event) => _createUser(event));
  }

  createUserWithEmail(String email, String password) async {
    if (email == null || password == null) {
      return null;
    }
    var loginCard = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return UserLocal.createUserByFirebase(loginCard.user!);
  }

  loginUserWithEmail(String email, String password) async {
    if (email == null || password == null) {
      return null;
    }
    var loginCard = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return UserLocal.createUserByFirebase(loginCard.user!);
  }

  signOut() async {
    await _firebaseAuth.signOut();
  }
}
