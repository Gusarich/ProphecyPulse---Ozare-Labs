// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Bet _$BetFromJson(Map<String, dynamic> json) {
  return _Bet.fromJson(json);
}

/// @nodoc
mixin _$Bet {
  String get id => throw _privateConstructorUsedError;
  String get eventId => throw _privateConstructorUsedError;

  /// userId to show bets in specific event
  String get userId => throw _privateConstructorUsedError;

  /// userName to show bets in specific event
  String get userName => throw _privateConstructorUsedError;
  String get tokens => throw _privateConstructorUsedError;
  String get score1 => throw _privateConstructorUsedError;
  String get score2 => throw _privateConstructorUsedError;
  String get team1 => throw _privateConstructorUsedError;
  String get team2 => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  String get logo1 => throw _privateConstructorUsedError;
  String get logo2 => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// 0 for team1, 1 for team2
  int get yourTeam => throw _privateConstructorUsedError;
  bool get won => throw _privateConstructorUsedError;
  bool get finished => throw _privateConstructorUsedError;

  /// Sport category: soccer, basketball
  String get category => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BetCopyWith<Bet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BetCopyWith<$Res> {
  factory $BetCopyWith(Bet value, $Res Function(Bet) then) =
      _$BetCopyWithImpl<$Res, Bet>;
  @useResult
  $Res call(
      {String id,
      String eventId,
      String userId,
      String userName,
      String tokens,
      String score1,
      String score2,
      String team1,
      String team2,
      String time,
      String logo1,
      String logo2,
      DateTime createdAt,
      int yourTeam,
      bool won,
      bool finished,
      String category});
}

/// @nodoc
class _$BetCopyWithImpl<$Res, $Val extends Bet> implements $BetCopyWith<$Res> {
  _$BetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? userName = null,
    Object? tokens = null,
    Object? score1 = null,
    Object? score2 = null,
    Object? team1 = null,
    Object? team2 = null,
    Object? time = null,
    Object? logo1 = null,
    Object? logo2 = null,
    Object? createdAt = null,
    Object? yourTeam = null,
    Object? won = null,
    Object? finished = null,
    Object? category = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as String,
      score1: null == score1
          ? _value.score1
          : score1 // ignore: cast_nullable_to_non_nullable
              as String,
      score2: null == score2
          ? _value.score2
          : score2 // ignore: cast_nullable_to_non_nullable
              as String,
      team1: null == team1
          ? _value.team1
          : team1 // ignore: cast_nullable_to_non_nullable
              as String,
      team2: null == team2
          ? _value.team2
          : team2 // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      logo1: null == logo1
          ? _value.logo1
          : logo1 // ignore: cast_nullable_to_non_nullable
              as String,
      logo2: null == logo2
          ? _value.logo2
          : logo2 // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      yourTeam: null == yourTeam
          ? _value.yourTeam
          : yourTeam // ignore: cast_nullable_to_non_nullable
              as int,
      won: null == won
          ? _value.won
          : won // ignore: cast_nullable_to_non_nullable
              as bool,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BetCopyWith<$Res> implements $BetCopyWith<$Res> {
  factory _$$_BetCopyWith(_$_Bet value, $Res Function(_$_Bet) then) =
      __$$_BetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String eventId,
      String userId,
      String userName,
      String tokens,
      String score1,
      String score2,
      String team1,
      String team2,
      String time,
      String logo1,
      String logo2,
      DateTime createdAt,
      int yourTeam,
      bool won,
      bool finished,
      String category});
}

/// @nodoc
class __$$_BetCopyWithImpl<$Res> extends _$BetCopyWithImpl<$Res, _$_Bet>
    implements _$$_BetCopyWith<$Res> {
  __$$_BetCopyWithImpl(_$_Bet _value, $Res Function(_$_Bet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? userName = null,
    Object? tokens = null,
    Object? score1 = null,
    Object? score2 = null,
    Object? team1 = null,
    Object? team2 = null,
    Object? time = null,
    Object? logo1 = null,
    Object? logo2 = null,
    Object? createdAt = null,
    Object? yourTeam = null,
    Object? won = null,
    Object? finished = null,
    Object? category = null,
  }) {
    return _then(_$_Bet(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as String,
      score1: null == score1
          ? _value.score1
          : score1 // ignore: cast_nullable_to_non_nullable
              as String,
      score2: null == score2
          ? _value.score2
          : score2 // ignore: cast_nullable_to_non_nullable
              as String,
      team1: null == team1
          ? _value.team1
          : team1 // ignore: cast_nullable_to_non_nullable
              as String,
      team2: null == team2
          ? _value.team2
          : team2 // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      logo1: null == logo1
          ? _value.logo1
          : logo1 // ignore: cast_nullable_to_non_nullable
              as String,
      logo2: null == logo2
          ? _value.logo2
          : logo2 // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      yourTeam: null == yourTeam
          ? _value.yourTeam
          : yourTeam // ignore: cast_nullable_to_non_nullable
              as int,
      won: null == won
          ? _value.won
          : won // ignore: cast_nullable_to_non_nullable
              as bool,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Bet with DiagnosticableTreeMixin implements _Bet {
  const _$_Bet(
      {required this.id,
      required this.eventId,
      required this.userId,
      required this.userName,
      required this.tokens,
      required this.score1,
      required this.score2,
      required this.team1,
      required this.team2,
      required this.time,
      required this.logo1,
      required this.logo2,
      required this.createdAt,
      required this.yourTeam,
      this.won = false,
      this.finished = false,
      required this.category});

  factory _$_Bet.fromJson(Map<String, dynamic> json) => _$$_BetFromJson(json);

  @override
  final String id;
  @override
  final String eventId;

  /// userId to show bets in specific event
  @override
  final String userId;

  /// userName to show bets in specific event
  @override
  final String userName;
  @override
  final String tokens;
  @override
  final String score1;
  @override
  final String score2;
  @override
  final String team1;
  @override
  final String team2;
  @override
  final String time;
  @override
  final String logo1;
  @override
  final String logo2;
  @override
  final DateTime createdAt;

  /// 0 for team1, 1 for team2
  @override
  final int yourTeam;
  @override
  @JsonKey()
  final bool won;
  @override
  @JsonKey()
  final bool finished;

  /// Sport category: soccer, basketball
  @override
  final String category;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Bet(id: $id, eventId: $eventId, userId: $userId, userName: $userName, tokens: $tokens, score1: $score1, score2: $score2, team1: $team1, team2: $team2, time: $time, logo1: $logo1, logo2: $logo2, createdAt: $createdAt, yourTeam: $yourTeam, won: $won, finished: $finished, category: $category)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Bet'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('eventId', eventId))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('userName', userName))
      ..add(DiagnosticsProperty('tokens', tokens))
      ..add(DiagnosticsProperty('score1', score1))
      ..add(DiagnosticsProperty('score2', score2))
      ..add(DiagnosticsProperty('team1', team1))
      ..add(DiagnosticsProperty('team2', team2))
      ..add(DiagnosticsProperty('time', time))
      ..add(DiagnosticsProperty('logo1', logo1))
      ..add(DiagnosticsProperty('logo2', logo2))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('yourTeam', yourTeam))
      ..add(DiagnosticsProperty('won', won))
      ..add(DiagnosticsProperty('finished', finished))
      ..add(DiagnosticsProperty('category', category));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bet &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.tokens, tokens) || other.tokens == tokens) &&
            (identical(other.score1, score1) || other.score1 == score1) &&
            (identical(other.score2, score2) || other.score2 == score2) &&
            (identical(other.team1, team1) || other.team1 == team1) &&
            (identical(other.team2, team2) || other.team2 == team2) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.logo1, logo1) || other.logo1 == logo1) &&
            (identical(other.logo2, logo2) || other.logo2 == logo2) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.yourTeam, yourTeam) ||
                other.yourTeam == yourTeam) &&
            (identical(other.won, won) || other.won == won) &&
            (identical(other.finished, finished) ||
                other.finished == finished) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      eventId,
      userId,
      userName,
      tokens,
      score1,
      score2,
      team1,
      team2,
      time,
      logo1,
      logo2,
      createdAt,
      yourTeam,
      won,
      finished,
      category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BetCopyWith<_$_Bet> get copyWith =>
      __$$_BetCopyWithImpl<_$_Bet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BetToJson(
      this,
    );
  }
}

abstract class _Bet implements Bet {
  const factory _Bet(
      {required final String id,
      required final String eventId,
      required final String userId,
      required final String userName,
      required final String tokens,
      required final String score1,
      required final String score2,
      required final String team1,
      required final String team2,
      required final String time,
      required final String logo1,
      required final String logo2,
      required final DateTime createdAt,
      required final int yourTeam,
      final bool won,
      final bool finished,
      required final String category}) = _$_Bet;

  factory _Bet.fromJson(Map<String, dynamic> json) = _$_Bet.fromJson;

  @override
  String get id;
  @override
  String get eventId;
  @override

  /// userId to show bets in specific event
  String get userId;
  @override

  /// userName to show bets in specific event
  String get userName;
  @override
  String get tokens;
  @override
  String get score1;
  @override
  String get score2;
  @override
  String get team1;
  @override
  String get team2;
  @override
  String get time;
  @override
  String get logo1;
  @override
  String get logo2;
  @override
  DateTime get createdAt;
  @override

  /// 0 for team1, 1 for team2
  int get yourTeam;
  @override
  bool get won;
  @override
  bool get finished;
  @override

  /// Sport category: soccer, basketball
  String get category;
  @override
  @JsonKey(ignore: true)
  _$$_BetCopyWith<_$_Bet> get copyWith => throw _privateConstructorUsedError;
}
