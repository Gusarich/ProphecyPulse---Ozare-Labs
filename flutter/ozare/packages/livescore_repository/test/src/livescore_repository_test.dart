// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:livescore_repository/src/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

import 'testing_data.dart';

void main() {
  group('LivescoreRepository', () {

    test('soccer passing to the respective league and event', () {
      // Parse the JSON file
      final jsonStr = jsonSoccerData;
      final jsonList = json.decode(jsonStr) as List<dynamic>;

      // Create a list of Event objects
      final events = jsonList
          .map((json) => Event(
                id: json['fixture']['id'].toString(),
                id1: json['teams']['home']['id'].toString(),
                id2: json['teams']['away']['id'].toString(),
                score1: json['goals']['home'].toString(),
                score2: json['goals']['away'].toString(),
                team1: json['teams']['home']['name'].toString(),
                team2: json['teams']['away']['name'].toString(),
                time: json['fixture']['date'].toString(),
                logo1: json['teams']['home']['logo'].toString(),
                logo2: json['teams']['away']['logo'].toString(),
                category: json['league']['name'].toString(),
              ))
          .toList();

      // Group the events by league ID
      final Map<String, List<Event>> eventsByLeague = {};
      for (final event in events) {
        final String leagueId = event.category;
        if (!eventsByLeague.containsKey(leagueId)) {
          eventsByLeague[leagueId] = [];
        }
        eventsByLeague[leagueId]!.add(event);
      }

      // Create a list of League objects
      final leagues = eventsByLeague.entries
          .map((entry) => League(
                id: entry.key,
                name: entry.value.first.category,
                events: entry.value,
              ))
          .toList();

      // Print the resulting leagues
      leagues.forEach((league) {
        print('${league.name} (${league.id}):');
        league.events.forEach((event) {
          print(
              '  ${event.team1} vs ${event.team2} (${event.score1}-${event.score2})');
        });
      });
    });
  });
}
