import 'dart:convert';

import 'package:local_api/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template auth_client}
/// Retrieve local auth data.
/// {@endtemplate}
class AuthClient {
  /// {@macro local_api}
  AuthClient({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  /// Gets user.
  Map<String, dynamic> getOwner() {
    final data = _sharedPreferences.getString(ConstString.userKey);
    return json.decode(data!) as Map<String, dynamic>;
  }

  /// Sets user.
  Future<void> setOwner(Map<String, dynamic> owner) async {
    await _sharedPreferences.setString(
      ConstString.userKey,
      json.encode(owner),
    );
  }

  /// Sets user.
  Future<void> clearOwner() async {
    await _sharedPreferences.remove(ConstString.userKey);
  }

  /// Sets whether is onboard.
  Future<void> saveOnboardStatus({required bool status}) {
    return _sharedPreferences.setBool(ConstString.onboard, status);
  }

  /// Gets whether is onboard.
  bool? getOnboardStatus() {
    final status = _sharedPreferences.getBool(ConstString.onboard);
    return status;
  }
  /// Sets language.
  Future<void> saveLanguage({required String language}) {
    return _sharedPreferences.setString(ConstString.language, language);
  }

  /// Gets language.
  String? getLanguage() {
    final language = _sharedPreferences.getString(ConstString.language);
    return language;
  }
}
