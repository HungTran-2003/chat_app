import 'dart:developer';

import 'package:chat_app/core/network/api_client.dart';
import 'package:chat_app/data/models/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiClientImpl implements ApiClient {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  ApiClientImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  @override
  Future<UserEntity> getUserInfo({required String uid}) async {
    final result = await _firestore.collection('users').doc(uid).get();
    if(result.data() == null){
      throw Exception('User not found');
    }
    try {
      log(result.data().toString());
      return UserEntity.fromJson(result.data()!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> loginByEmail({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    log(userCredential.toString());
    return userCredential;
  }

  @override
  Future registerAccount({
    required String userName,
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = userCredential.user!.uid;

    final user = await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'user_name': userName,
      'created_at': FieldValue.serverTimestamp(),
      'avatar_path': null,
    });

    return user;
  }
}
