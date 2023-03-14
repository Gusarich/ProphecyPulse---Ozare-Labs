import 'dart:convert';

import 'package:local_api/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template livescore}
/// Retrieve local livescore data.
/// {@endtemplate}
class LivescoreApi {
  /// {@macro livescore}
  LivescoreApi({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  /// Gets league.
  Map<String, dynamic>? getLeague(String category) {
    final data = _sharedPreferences.getString(ConstString.leagueBox + category);
    if (data == null) {
      return null;
    }
    return json.decode(data) as Map<String, dynamic>?;
  }

  /// Sets league.
  Future<void> setLeague(Map<String, dynamic> league, String category) async {
    await _sharedPreferences.setString(
      ConstString.leagueBox + category,
      json.encode(league),
    );
  }

  /// Gets team.
  Map<String, dynamic>? getTeams(String defaultQuery) {
    final data = _sharedPreferences.getString(ConstString.team + defaultQuery);
    if (data == null) {
      return null;
    }
    return json.decode(data) as Map<String, dynamic>?;
  }

  /// Sets team.
  Future<void> setTeam(Map<String, dynamic> team, String defaultQuery) async {
    await _sharedPreferences.setString(
      ConstString.team + defaultQuery,
      json.encode(team),
    );
  }

  /// Gets event.
  Map<String, dynamic>? getEventScoreboard(String eid, String category) {
    final data = _sharedPreferences.getString(
      ConstString.event + eid + category,
    );
    if (data == null) {
      return null;
    }
    return json.decode(data) as Map<String, dynamic>?;
  }

  /// Sets event.
  Future<void> setEventScoreboard(
    Map<String, dynamic> event,
    String eid,
    String category,
  ) async {
    await _sharedPreferences.setString(
      ConstString.event + eid + category,
      json.encode(event),
    );
  }

  /// Gets live match by team.
  Map<String, dynamic>? getLiveMatchByTeam(int defaultTeamId) {
    final data = _sharedPreferences.getString(
      ConstString.liveMatchByTeam + defaultTeamId.toString(),
    );
    if (data == null) {
      return null;
    }
    return json.decode(data) as Map<String, dynamic>?;
  }

  /// Sets live match by team.
  Future<void> setLiveMatchByTeam(
    Map<String, dynamic> liveMatch,
    int defaultTeamId,
  ) async {
    await _sharedPreferences.setString(
      ConstString.liveMatchByTeam + defaultTeamId.toString(),
      json.encode(liveMatch),
    );
  }
}
