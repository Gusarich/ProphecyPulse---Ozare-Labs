import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fixture.freezed.dart';

@freezed
class Fixture with _$Fixture {
  const factory Fixture({
    required int id,
    required String date,
    required String venueName,
    required String venueCity,
    required int team1ID,
    required int team2ID,
    required String team1Name,
    required String team2Name,
    required String team1Logo,
    required String team2Logo,
  }) = _Fixture;
}
