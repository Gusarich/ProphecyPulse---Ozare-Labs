import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/src/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_api/local_api.dart' as local;
import 'package:shared_preferences/shared_preferences.dart';

/// {@template ozare_repository}
/// Repository which manages Ozare authentication.
/// {@endtemplate}
class OzareRepository {
  /// {@macro ozare_repository}
  OzareRepository({
    required local.AuthClient authClient,
    FirebaseFirestore? firestore,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _authClient = authClient;

  final FirebaseFirestore _firestore;
  final local.AuthClient _authClient;

  Map<String, dynamic>? _localOwner;

  Map<String, dynamic>? get owner => _localOwner;

  /// Signs in user with email and password
  Future<OUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credentials = await FirebaseRepository().logInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final docs =
          await _firestore.collection('users').doc(credentials.user!.uid).get();

      return OUser.fromJson(docs.data()!);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<OUser> signUpWithEmailAndPassword({
    required OUser oUser,
    required String password,
  }) async {
    try {
      final credentials = await FirebaseRepository().signUp(
        email: oUser.email,
        password: password,
      );
      oUser = oUser.copyWith(
        uid: credentials.user!.uid,
      );

      await _firestore
          .collection('users')
          .doc(credentials.user!.uid)
          .set(oUser.toJson());
      return oUser;
    } catch (e) {
      throw OzareSignUpWithEmailAndPasswordFailure(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseRepository().logOut();
    } catch (e) {
      throw OzareLogOutFailure(e.toString());
    }
  }

  // Stream<OUser> getOwner(String uid) {
  //   try {
  //     return _firestore
  //         .collection('users')
  //         .doc(uid)
  //         .snapshots()
  //         .map((event) => OUser.fromJson(event.data()!));
  //   } catch (e) {
  //     throw OzareGetOwnerException(e.toString());
  //   }
  // }

  Future<OUser> signInWithGoogle() async {
    try {
      final credentials = await FirebaseRepository().logInWithGoogle();
      final user = credentials.user;

      final docs = await _firestore.collection('users').doc(user!.uid).get();

      if (docs.exists) {
        return OUser.fromJson(docs.data()!);
      } else {
        final oUser = OUser(
          uid: user.uid,
          email: user.email!,
          firstName: user.displayName ?? '',
          lastName: '',
        );

        await _firestore.collection('users').doc(user.uid).set(oUser.toJson());

        return oUser;
      }
    } catch (e) {
      throw OzareSignWithGoogleException(e.toString());
    }
  }

  Map<String, dynamic>? getLocalOwner() {
    _localOwner = _authClient.getOwner();
    return _localOwner;
  }

  Future<void> setLocalOwner(Map<String, dynamic> owner) async =>
      _authClient.setOwner(owner);

  Future<void> clearLocalOwner() async => _authClient.clearOwner();

  Future<void> saveLocalOnboardStatus({required bool status}) async =>
      _authClient.saveOnboardStatus(status: status);

  bool? getLocalOnboardStatus() => _authClient.getOnboardStatus();

  Future<void> saveLocalLanguage({required String language}) async =>
      _authClient.saveLanguage(language: language);

  String? getLocalLanguage() => _authClient.getLanguage();
}
