// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Bet _$$_BetFromJson(Map<String, dynamic> json) => _$_Bet(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      tokens: json['tokens'] as String,
      score1: json['score1'] as String,
      score2: json['score2'] as String,
      team1: json['team1'] as String,
      team2: json['team2'] as String,
      time: json['time'] as String,
      logo1: json['logo1'] as String,
      logo2: json['logo2'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      yourTeam: json['yourTeam'] as int,
      won: json['won'] as bool? ?? false,
      finished: json['finished'] as bool? ?? false,
      category: json['category'] as String,
    );

Map<String, dynamic> _$$_BetToJson(_$_Bet instance) => <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'userId': instance.userId,
      'userName': instance.userName,
      'tokens': instance.tokens,
      'score1': instance.score1,
      'score2': instance.score2,
      'team1': instance.team1,
      'team2': instance.team2,
      'time': instance.time,
      'logo1': instance.logo1,
      'logo2': instance.logo2,
      'createdAt': instance.createdAt.toIso8601String(),
      'yourTeam': instance.yourTeam,
      'won': instance.won,
      'finished': instance.finished,
      'category': instance.category,
    };
