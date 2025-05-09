import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Thoughts: I could have created separate services for firestore and storage but for now its good enough
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> login(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> register(
      {required String email,
      required String name,
      required String password,
      required File imageFile}) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;

    final ref = _storage.ref().child('profile_images/$uid.jpg');
    final uploadTask = ref.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});
    final imageUrl = await snapshot.ref.getDownloadURL();

    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    });
  }

  Future<void> logout() {
    return _auth.signOut();
  }
}
