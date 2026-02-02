import 'dart:developer';

import 'package:chat_app/core/network/api_client.dart';
import 'package:chat_app/data/entities/contact_entity.dart';
import 'package:chat_app/data/entities/user_entity.dart';
import 'package:chat_app/data/enum/contact_status.dart';
import 'package:chat_app/data/models/contact_model.dart';
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
    if (result.data() == null) {
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

  @override
  Future<ContactEntity> createContact({
    required UserEntity currentUser,
    required UserEntity contactUser,
  }) async {
    final contactModel = ContactModel(
      status: ContactStatus.pending,
      createdAt: DateTime.now(),
      requestId: currentUser.uid,
      user: [currentUser, contactUser],
    );

    final result = await _firestore
        .collection('contacts')
        .add(contactModel.toJson());
    return ContactEntity(
      uid: result.id,
      status: contactModel.status,
      createdAt: contactModel.createdAt,
      updateAt: contactModel.updateAt,
      requestId: contactModel.requestId,
      user: contactModel.user?.first,
    );
  }

  @override
  Future<List<UserEntity>> searchUser({
    required String keyword,
    int? limit = 20,
  }) async {
    if (keyword.trim().isEmpty) return [];
    final key = keyword.toLowerCase();

    final nameQuery = _firestore
        .collection('users')
        .orderBy('user_name_lower')
        .startAt([key])
        .endAt(['$key\uf8ff'])
        .limit(limit!);

    final emailQuery = _firestore
        .collection('users')
        .orderBy('email_lower')
        .startAt([key])
        .endAt(['$key\uf8ff'])
        .limit(limit);

    final results = await Future.wait([nameQuery.get(), emailQuery.get()]);

    final Map<String, UserEntity> users = {};

    for (var snap in results) {
      for (var doc in snap.docs) {
        users[doc.id] = UserEntity.fromJson(doc.data());
      }
    }
    return users.values.toList();
  }
}
