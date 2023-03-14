// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OUser _$$_OUserFromJson(Map<String, dynamic> json) => _$_OUser(
      uid: json['uid'] as String?,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      photoURL: json['photoURL'] as String? ?? '',
      gender: json['gender'] as int? ?? 1,
      dob: json['dob'] as String? ?? '',
      wins: json['wins'] as int? ?? 0,
      losses: json['losses'] as int? ?? 0,
      ballance: (json['ballance'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$_OUserToJson(_$_OUser instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'photoURL': instance.photoURL,
      'gender': instance.gender,
      'dob': instance.dob,
      'wins': instance.wins,
      'losses': instance.losses,
      'ballance': instance.ballance,
    };
