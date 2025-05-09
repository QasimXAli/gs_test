import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> login(String email, String password) {
    return _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((cred) => cred.user);
  }

  Future<User?> register(String email, String password) {
    return _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((cred) => cred.user);
  }

  Future<void> logout() {
    return _auth.signOut();
  }
}
