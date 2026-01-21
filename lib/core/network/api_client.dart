import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiClient {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  ApiClient(this._auth, this._firestore);
}
