import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class DatabaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final DateTime timeCreated = DateTime.now();

  Future<User> getUser() async {
    return _auth.currentUser;
  }

  Stream<User> get user => _auth.authStateChanges();

// setted first user values
  Future<void> createUserData(User user) {
    DocumentReference userRef = _db.collection('Users').doc(user.uid);

    return userRef.set(
      {
        'uid': user.uid,
        'isAdmin': false,
        'userEmail': user.email,
        'created': timeCreated,
      },
    );
  }

  //! signout
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
