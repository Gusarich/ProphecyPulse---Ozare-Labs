import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ozare_repository/src/features/bet/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ozare_repository/src/features/profile/models/models.dart';

class ProfileRepository {
  ProfileRepository({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _storage = storage,
        _firestore = firestore;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  /// Get the user's profile
  Stream<OUser> oUserStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) => OUser.fromJson(snapshot.data()!));
  }

  /// User's history stream
  Stream<List<Bet>> historyStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('history')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Bet.fromJson(doc.data())).toList()
                ..sort(
                  (a, b) => b.createdAt.compareTo(a.createdAt),
                ),
        );
  }

  /// User's notifications stream
  Stream<List<Bet>> notificationStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('notification')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Bet.fromJson(doc.data())).toList()
                ..sort(
                  (a, b) => b.createdAt.compareTo(a.createdAt),
                ),
        );
  }

  /// Update the user's profile
  Future<void> updateProfile(OUser oUser) async {
    await _firestore.collection('users').doc(oUser.uid).update(oUser.toJson());
  }

  /// Upload the user's profile image to firebase storage
  Future<String> uploadPhoto(String uid, XFile imageFile) async {
    final ref = _storage.ref().child('users/$uid/profile.jpg');

    if (kIsWeb) {
      final bytes = await imageFile.readAsBytes();
      await ref.putData(bytes);
    } else {
      await ref.putFile(File(imageFile.path));
    }

    return ref.getDownloadURL();
  }
}
