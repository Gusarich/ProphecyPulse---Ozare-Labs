import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String id1,
    required String id2,
    required String score1,
    required String score2,
    required String team1,
    required String team2,
    required String time,
    required String logo1,
    required String logo2,
    required String category,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
