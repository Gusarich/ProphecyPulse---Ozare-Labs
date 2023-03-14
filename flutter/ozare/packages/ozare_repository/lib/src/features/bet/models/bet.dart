import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bet.freezed.dart';
part 'bet.g.dart';

@freezed
class Bet with _$Bet {
  const factory Bet({
    required String id,
    required String eventId,

    /// userId to show bets in specific event
    required String userId,

    /// userName to show bets in specific event
    required String userName,
    required String tokens,
    required String score1,
    required String score2,
    required String team1,
    required String team2,
    required String time,
    required String logo1,
    required String logo2,
    required DateTime createdAt,

    /// 0 for team1, 1 for team2
    required int yourTeam,
    @Default(false) bool won,
    @Default(false) bool finished,

    /// Sport category: soccer, basketball
    required String category,
  }) = _Bet;

  factory Bet.fromJson(Map<String, dynamic> json) => _$BetFromJson(json);
}
