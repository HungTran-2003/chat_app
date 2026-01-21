import 'package:chat_app/core/network/api_client.dart';
import 'package:chat_app/core/network/api_client_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiUtils{
  static ApiClient get apiClient => ApiClientImpl(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
}