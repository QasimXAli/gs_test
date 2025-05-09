import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gs_test/models/app_user.dart';

class HomeProvider extends ChangeNotifier {
  //Thoughts: Creating a separate firestore service and Injecting it into this provider would've been a better approach.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Stream<List<AppUser>> get usersStream => _getUsersStream();

  Stream<List<AppUser>> _getUsersStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => AppUser.fromMap(doc.data())).toList();
    });
  }
}
