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

      return defaultLeague(remoteData, parsedLeagues, category);
    } catch (e) {
      return parsedLeagues;
    }
  }

  List<League> defaultLeague(
    Map<String, dynamic> data,
    List<League> parsedLeagues,
    String category,
  ) {
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
      try {
        final match = _parseEventDefault(event, category);
        matches.add(match);
      } catch (e) {
        throw LivescoreRepoParseEventsException(e.toString());
      }
    }

    return matches;
  }

  Event _parseEventDefault(dynamic event, String category) {
    final hasLogos =
        event['T1'][0]['Img'] != null && event['T2'][0]['Img'] != null;
    final notStarted = event['Eps'].toString().contains('NS');
    final postponed = event['Eps'].toString().contains('Postp.');

    return Event(
      id: event['Eid'].toString(),
      category: category,
      team1: event['T1'][0]['Nm'].toString(),
      team2: event['T2'][0]['Nm'].toString(),
      id1: event['T1'][0]['ID'].toString(),
      id2: event['T2'][0]['ID'].toString(),
      logo1: hasLogos
          ? LivescoreApiClient.logoBaseUrl + event['T1'][0]['Img'].toString()
          : '',
      logo2: hasLogos
          ? LivescoreApiClient.logoBaseUrl + event['T2'][0]['Img'].toString()
          : '',
      score1: event['Tr1'].toString().contains('null')
          ? ''
          : event['Tr1'].toString(),
      score2: event['Tr2'].toString().contains('null')
          ? ''
          : event['Tr2'].toString(),
      time: notStarted
          ? ''
          : postponed
              ? 'Postponed'
              : event['Eps'].toString(),
    );
  }

  //FIXME - Rework on this to get data from the database not
  Future<Event?> getEventScoreboard({
    required String eid,
    required String category,
  }) async {
    try {
      final event = await _livescoreApiClient.getEventScoreboard(
        eid: eid,
        category: category,
      );

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
  Future<List<Team>> getSoccerTeams(String query) async {
    final parsedTeams = <Team>[];
    try {
      final teams = await _livescoreApiClient.getTeams(query);

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

  /// Returns a list of [Team] when searched with a [query] and [category].
  Future<List<Team>> searchTeamsByCategory(
    String query,
    String category,
  ) async {
    try {
      final teamFutures = <Future<Team>>[];
      final teamsJson = await _livescoreApiClient.searchTeam(query, category);
      final responses = teamsJson['results'] as Iterable<dynamic>;

      for (final result in responses) {
        if (result['type'].toString().contains('team')) {
          teamFutures.add(
            () async {
              final entity = result['entity'] as Map<String, dynamic>;
              final logo = await _livescoreApiClient.getTeamImage(
                category,
                entity['id'] as int,
              );

              // Extract the country name if available
              final country =
                  entity['country']['name'].toString().contains('null')
                      ? ''
                      : entity['country']['name'].toString();

              return Team(
                id: entity['id'] as int,
                name: entity['name'].toString(),
                country: country,
                logo: '',
              );
            }(),
          );
        }
      }

      final teams = await Future.wait(teamFutures);

      return teams;
    } catch (e) {
      rethrow;
    }
  }

  /// Returns a list of fixtures related to the team with [teamId] and [category]
  Future<List<Fixture>> getScheduleMatchByCategory(
      int teamId, String category) async {
    final fixtures = <Fixture>[];

    try {
      final data = await _livescoreApiClient.getScheduleMatchByCategory(
        teamId,
        category,
      );
      final responses = data['events'] as Iterable<dynamic>;

      for (final result in responses) {
        try {
          final startTimestamp = result['startTimestamp'] as int;
          final date =
              DateTime.fromMillisecondsSinceEpoch(startTimestamp * 1000);
          final team1Json = result['homeTeam'] as Map<String, dynamic>;
          final team2Json = result['awayTeam'] as Map<String, dynamic>;
          final team1ID = team1Json['id'] as int;
          final team2ID = team2Json['id'] as int;
          final team1Name = team1Json['name'] as String;
          final team2Name = team2Json['name'] as String;
          final team1Logo =
              await _livescoreApiClient.getTeamImage(category, team1ID);
          final team2Logo =
              await _livescoreApiClient.getTeamImage(category, team2ID);

          if (date.isBefore(DateTime.now())) {
            continue;
          }

          final fixture = Fixture(
            id: result['id'] as int,
            date: date.toString(),
            venueName: '',
            venueCity: '',
            team1ID: team1ID,
            team2ID: team2ID,
            team1Name: team1Name,
            team2Name: team2Name,
            team1Logo: team1Logo,
            team2Logo: team2Logo,
          );

          fixtures.add(fixture);
        } catch (_) {
          continue;
        }
      }
    } catch (_) {}

    return fixtures;
  }

  /// Returns a list of fixtures related to the team with [teamId]
  Future<List<Fixture>> getLiveMatchByTeam(int teamId) async {
    final fixtures = <Fixture>[];
    final currentDate = DateTime.now();

    //FIXME - Add expiry for local data storage
    var data = _localLivescoreClient.getLiveMatchByTeam(teamId);
    if (data == null) {
      final remoteData = await _livescoreApiClient.getLiveMatchByTeam(teamId);

      await _localLivescoreClient.setLiveMatchByTeam(remoteData, teamId);
      data = remoteData;
    }
    try {
      if (data['results'] as int < 1) return fixtures;

      final responses = data['response'] as List;

      for (final response in responses) {
        try {
          // extract Event Fields
          final id = response['fixture']['id'] as int;

          final venueName = response['fixture']['venue']['name'] as String;
          final venueCity = response['fixture']['venue']['city'] as String;
          final date = response['fixture']['date'] as String;

          final team1 = response['teams']['home']['name'] as String;
          final logo1 = response['teams']['home']['logo'] as String;
          final id1 = response['teams']['home']['id'] as int;

          final team2 = response['teams']['away']['name'] as String;
          final logo2 = response['teams']['away']['logo'] as String;
          final id2 = response['teams']['away']['id'] as int;

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
