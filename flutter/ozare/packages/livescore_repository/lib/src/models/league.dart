import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'event.dart';

part 'league.freezed.dart';

@freezed
class League with _$League {
  const factory League({
    required String id,
    required String name,
    required List<Event> events,
  }) = _League;
}
