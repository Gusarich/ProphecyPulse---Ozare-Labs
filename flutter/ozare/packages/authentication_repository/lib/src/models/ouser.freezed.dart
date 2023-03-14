// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ouser.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OUser _$OUserFromJson(Map<String, dynamic> json) {
  return _OUser.fromJson(json);
}

/// @nodoc
mixin _$OUser {
  /// required at sign up
  String? get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;

  /// can be updated at profile page
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;

  /// Gender: 1 Male, 0 Female
  int? get gender => throw _privateConstructorUsedError;
  String? get dob => throw _privateConstructorUsedError;

  /// Other fields
  int get wins => throw _privateConstructorUsedError;
  int get losses => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OUserCopyWith<OUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OUserCopyWith<$Res> {
  factory $OUserCopyWith(OUser value, $Res Function(OUser) then) =
      _$OUserCopyWithImpl<$Res, OUser>;
  @useResult
  $Res call(
      {String? uid,
      String email,
      String firstName,
      String lastName,
      String? phoneNumber,
      String? photoURL,
      int? gender,
      String? dob,
      int wins,
      int losses,
      double balance});
}

/// @nodoc
class _$OUserCopyWithImpl<$Res, $Val extends OUser>
    implements $OUserCopyWith<$Res> {
  _$OUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phoneNumber = freezed,
    Object? photoURL = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? wins = null,
    Object? losses = null,
    Object? balance = null,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OUserCopyWith<$Res> implements $OUserCopyWith<$Res> {
  factory _$$_OUserCopyWith(_$_OUser value, $Res Function(_$_OUser) then) =
      __$$_OUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uid,
      String email,
      String firstName,
      String lastName,
      String? phoneNumber,
      String? photoURL,
      int? gender,
      String? dob,
      int wins,
      int losses,
      double balance});
}

/// @nodoc
class __$$_OUserCopyWithImpl<$Res> extends _$OUserCopyWithImpl<$Res, _$_OUser>
    implements _$$_OUserCopyWith<$Res> {
  __$$_OUserCopyWithImpl(_$_OUser _value, $Res Function(_$_OUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phoneNumber = freezed,
    Object? photoURL = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? wins = null,
    Object? losses = null,
    Object? balance = null,
  }) {
    return _then(_$_OUser(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OUser with DiagnosticableTreeMixin implements _OUser {
  const _$_OUser(
      {required this.uid,
      required this.email,
      required this.firstName,
      required this.lastName,
      this.phoneNumber = '',
      this.photoURL = '',
      this.gender = 1,
      this.dob = '',
      this.wins = 0,
      this.losses = 0,
      this.balance = 0.0});

  factory _$_OUser.fromJson(Map<String, dynamic> json) =>
      _$$_OUserFromJson(json);

  /// required at sign up
  @override
  final String? uid;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;

  /// can be updated at profile page
  @override
  @JsonKey()
  final String? phoneNumber;
  @override
  @JsonKey()
  final String? photoURL;

  /// Gender: 1 Male, 0 Female
  @override
  @JsonKey()
  final int? gender;
  @override
  @JsonKey()
  final String? dob;

  /// Other fields
  @override
  @JsonKey()
  final int wins;
  @override
  @JsonKey()
  final int losses;
  @override
  @JsonKey()
  final double balance;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OUser(uid: $uid, email: $email, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, photoURL: $photoURL, gender: $gender, dob: $dob, wins: $wins, losses: $losses, balance: $balance)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OUser'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('photoURL', photoURL))
      ..add(DiagnosticsProperty('gender', gender))
      ..add(DiagnosticsProperty('dob', dob))
      ..add(DiagnosticsProperty('wins', wins))
      ..add(DiagnosticsProperty('losses', losses))
      ..add(DiagnosticsProperty('balance', balance));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OUser &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.wins, wins) || other.wins == wins) &&
            (identical(other.losses, losses) || other.losses == losses) &&
            (identical(other.balance, balance) || other.balance == balance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uid, email, firstName, lastName,
      phoneNumber, photoURL, gender, dob, wins, losses, balance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OUserCopyWith<_$_OUser> get copyWith =>
      __$$_OUserCopyWithImpl<_$_OUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OUserToJson(
      this,
    );
  }
}

abstract class _OUser implements OUser {
  const factory _OUser(
      {required final String? uid,
      required final String email,
      required final String firstName,
      required final String lastName,
      final String? phoneNumber,
      final String? photoURL,
      final int? gender,
      final String? dob,
      final int wins,
      final int losses,
      final double balance}) = _$_OUser;

  factory _OUser.fromJson(Map<String, dynamic> json) = _$_OUser.fromJson;

  @override

  /// required at sign up
  String? get uid;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override

  /// can be updated at profile page
  String? get phoneNumber;
  @override
  String? get photoURL;
  @override

  /// Gender: 1 Male, 0 Female
  int? get gender;
  @override
  String? get dob;
  @override

  /// Other fields
  int get wins;
  @override
  int get losses;
  @override
  double get balance;
  @override
  @JsonKey(ignore: true)
  _$$_OUserCopyWith<_$_OUser> get copyWith =>
      throw _privateConstructorUsedError;
}
