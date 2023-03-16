import 'dart:developer';

import 'package:livescore_api/livescore_api.dart';
import 'package:livescore_repository/src/exceptions/exceptions.dart';
import 'package:livescore_repository/src/models/models.dart';
import 'package:local_api/local_api.dart' as local;

/// {@template livescore_repository}
/// A livescore repository  dart package.
/// {@endtemplate}
class LivescoreRepository {
  /// {@macro livescore_repository}
  LivescoreRepository({
    LivescoreApiClient? livescoreApiClient,
    required local.LivescoreApi localLivescoreClient,
  })  : _livescoreApiClient = livescoreApiClient ?? LivescoreApiClient(),
        _localLivescoreClient = localLivescoreClient;

  final LivescoreApiClient _livescoreApiClient;
  final local.LivescoreApi _localLivescoreClient;

  Future<List<League>> getLeagues(
    String category,
  ) async {
    final parsedLeagues = <League>[];
    try {
      final remoteData = await _livescoreApiClient.getLeagues(
        category,
      );

      print('category:$remoteData');
      return defaultLeague(remoteData, parsedLeagues, category);
    } catch (e) {
      return parsedLeagues;
    }
  }

  List<League> defaultLeague(
      Map<String, dynamic> data, List<League> parsedLeagues, String category) {
    // Check if the data contains any leagues before parsing it
    if (data['Stages'] == null ||
        (data['Stages'] as Iterable<dynamic>).isEmpty) {
      return parsedLeagues;
    }

    final leagues = data['Stages'] as Iterable<dynamic>;

    for (final e in leagues) {
      final events = e['Events'] as List<dynamic>;
      final parsedEvents = _parseEvents(events, category);
      if (parsedEvents.isEmpty) continue;

      final league = League(
        id: (e['Sid'] ?? '') as String,
        name: (e['Snm'] ?? '') as String,
        events: parsedEvents,
      );

      parsedLeagues.add(league);
    }
    return parsedLeagues;
  }

  List<Event> _parseEvents(List<dynamic> events, String category) {
    final matches = <Event>[];
    for (final event in events) {
      final Event match;
      try {
        if (event['T1'][0]['Img'] != null && event['T2'][0]['Img'] != null) {
          match = Event(
            id: event['Eid'] as String,
            category: category,
            team1: event['T1'][0]['Nm'] as String,
            team2: event['T2'][0]['Nm'] as String,
            id1: event['T1'][0]['ID'] as String,
            id2: event['T2'][0]['ID'] as String,
            logo1: LivescoreApiClient.logoBaseUrl +
                (event['T1'][0]['Img'] as String),
            logo2: LivescoreApiClient.logoBaseUrl +
                (event['T2'][0]['Img'] as String),
            score1: event['Tr1'] as String,
            score2: event['Tr2'] as String,
            time: (event['Eps'] as String).replaceAll('\'', ''),
          );
        } else {
          match = Event(
            id: event['Eid'] as String,
            category: category,
            team1: event['T1'][0]['Nm'] as String,
            team2: event['T2'][0]['Nm'] as String,
            id1: event['T1'][0]['ID'] as String,
            id2: event['T2'][0]['ID'] as String,
            logo1: '',
            logo2: '',
            score1: event['Tr1C2'].toString().contains('null')
                ? ''
                : event['Tr1C2'].toString(),
            score2: event['Tr2C2'].toString().contains('null')
                ? ''
                : event['Tr2C2'].toString(),
            time: event['Eps'] as String,
          );
        }
        matches.add(match);
      } catch (e) {
        throw LivescoreRepoParseEventsException(e.toString());
      }
    }
    return matches;
  }

  Future<Event?> getEventScoreboard({
    required String eid,
    required String category,
  }) async {
    try {
      var event = _localLivescoreClient.getEventScoreboard(eid, category);
      if (event == null) {
        final remoteData = await _livescoreApiClient.getEventScoreboard(
          eid: eid,
          category: category,
        );
        await _localLivescoreClient.setEventScoreboard(
          remoteData,
          eid,
          category,
        );
        event = remoteData;
      }

      final match = Event(
        category: category,
        id: event['Eid'] as String,
        team1: event['T1'][0]['Nm'] as String,
        team2: event['T2'][0]['Nm'] as String,
        id1: event['T1'][0]['ID'] as String,
        id2: event['T2'][0]['ID'] as String,
        logo1:
            LivescoreApiClient.logoBaseUrl + (event['T1'][0]['Img'] as String),
        logo2:
            LivescoreApiClient.logoBaseUrl + (event['T2'][0]['Img'] as String),
        score1: event['Tr1'] as String,
        score2: event['Tr2'] as String,
        time: (event['Eps'] as String).replaceAll("'", ''),
      );
      return match;
    } catch (e) {
      return null;
    }
  }

  /// Returns a list of team when searched with a [query].
  Future<List<Team>> getTeams(String query) async {
    final parsedTeams = <Team>[];
    const defaultQuery = 'manchester';
    try {
      var teams = _localLivescoreClient.getTeams(defaultQuery);
      if (teams == null) {
        final remoteData = await _livescoreApiClient.getTeams(defaultQuery);
        await _localLivescoreClient.setTeam(remoteData, defaultQuery);
        teams = remoteData;
      }

      final responses = teams['response'] as Iterable<dynamic>;

      for (final response in responses) {
        final teamResponse = response['team'] as Map<String, dynamic>;

        final team = Team.fromJson(teamResponse);
        parsedTeams.add(team);
      }

      return parsedTeams;
    } catch (_) {
      rethrow;
    }
  }

  /// Returns a list of fixtures related to the team with [teamId]
  Future<List<Fixture>> getLiveMatchByTeam(int teamId) async {
    final fixtures = <Fixture>[];
    final currentDate = DateTime.now();
    const defaultTeamId = 33;
    var data = _localLivescoreClient.getLiveMatchByTeam(defaultTeamId);
    if (data == null) {
      final remoteData =
          await _livescoreApiClient.getLiveMatchByTeam(defaultTeamId);

      await _localLivescoreClient.setLiveMatchByTeam(remoteData, defaultTeamId);
      data = remoteData;
    }
    try {
      if (data['results'] as int < 1) return fixtures;

      final responses = data['response'] as List;

      for (final response in responses) {
        try {
          // extract Event Fields
          final int id = response['fixture']['id'] as int;

          final String venueName =
              response['fixture']['venue']['name'] as String;
          final String venueCity =
              response['fixture']['venue']['city'] as String;
          final String date = response['fixture']['date'] as String;

          final String team1 = response['teams']['home']['name'] as String;
          final String logo1 = response['teams']['home']['logo'] as String;
          final int id1 = response['teams']['home']['id'] as int;

          final String team2 = response['teams']['away']['name'] as String;
          final String logo2 = response['teams']['away']['logo'] as String;
          final int id2 = response['teams']['away']['id'] as int;

          ///
          final d = DateTime.parse(date);
          if (d.isBefore(currentDate)) {
            continue;
          }

          fixtures.add(
            Fixture(
              id: id,
              date: date,
              venueName: venueName,
              venueCity: venueCity,
              team1ID: id1,
              team2ID: id2,
              team1Name: team1,
              team2Name: team2,
              team1Logo: logo1,
              team2Logo: logo2,
            ),
          );
        } catch (e) {
          continue;
        }
      }
    } catch (_) {}
    return fixtures;
  }
}
