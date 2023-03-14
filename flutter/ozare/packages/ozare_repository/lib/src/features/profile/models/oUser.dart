import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'oUser.freezed.dart';
part 'oUser.g.dart';

@freezed
class OUser with _$OUser {
  const factory OUser({
    /// required at sign up
    required String? uid,
    required String email,
    required String firstName,
    required String lastName,

    /// can be updated at profile page
    @Default('') String? phoneNumber,
    @Default('') String? photoURL,

    /// Gender: 1 Male, 0 Female
    @Default(1) int? gender,
    @Default('') String? dob,

    /// Other fields
    @Default(0) int wins,
    @Default(0) int losses,
    @Default(0.0) double ballance,
  }) = _OUser;

  factory OUser.fromJson(Map<String, dynamic> json) => _$OUserFromJson(json);
}
