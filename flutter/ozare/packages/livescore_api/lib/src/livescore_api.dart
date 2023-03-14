import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:livescore_api/src/exceptions/exceptions.dart';

class LivescoreApiClient {
  LivescoreApiClient({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();
  final _baseUrlLivescore = 'https://livescore6.p.rapidapi.com';
  final _baseUrlApiFootball = 'https://api-football-v1.p.rapidapi.com';
  static const String logoBaseUrl =
      'https://lsm-static-prod.livescore.com/medium/';
  final http.Client _httpClient;
  final _year = DateTime.now().year - 1;

  final _apiHeadersLivescore = {
    'x-rapidapi-host': 'livescore6.p.rapidapi.com',
    // 'x-rapidapi-key':
    //     '07585b4120mshbc941a57c6ebd11p11de9bjsn089233df6ab2', //(tomer)
    // 'x-rapidapi-key': '677ef2cd77msha0f0a52eab478a1p1cef4fjsn2932c3c06fef', (4xmafole)
    'x-rapidapi-key': '331091ac02msh9add992454a91b5p1a80dbjsn1d51b2ec3971',
  };
  final _apiHeadersApiFootball = {
    'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
    'x-rapidapi-key':
        '07585b4120mshbc941a57c6ebd11p11de9bjsn089233df6ab2', //(tomer)
    // 'x-rapidapi-key': '677ef2cd77msha0f0a52eab478a1p1cef4fjsn2932c3c06fef', (4xmafole)
    // 'x-rapidapi-key': '331091ac02msh9add992454a91b5p1a80dbjsn1d51b2ec3971', //(Erick)
  };

  // Gets the live league matches
  Future<Map<String, dynamic>> getLeagues(
    String category,
  ) async {
    return defaultLeagues(category);
  }

  /// Returns a map of leagues on [category].
  Future<Map<String, dynamic>> defaultLeagues(String category) async {
    try {
      final url = '$_baseUrlLivescore/matches/v2/list-live?Category=$category';

      final response = await _httpClient.get(
        Uri.parse(url),
        headers: _apiHeadersLivescore,
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      return data;
    } catch (e) {
      throw const LivescoreGetLeaguesException();
    }
  }

  /// Returns a map of event scoreboard.
  Future<Map<String, dynamic>> getEventScoreboard({
    required String eid,
    required String category,
  }) async {
    try {
      final url =
          '$_baseUrlLivescore/matches/v2/get-scoreboard?category=$category&Eid=$eid';

      final response = await _httpClient.get(
        Uri.parse(url),
        headers: _apiHeadersLivescore,
      );

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw const LivescoreGetEventScoreboardException();
    }
  }

  /// Search a team respective to the [query]
  Future<Map<String, dynamic>> getTeams(String query) async {
    try {
      final url = '$_baseUrlApiFootball/v3/teams?search=$query';

      final response = await _httpClient.get(
        Uri.parse(url),
        headers: _apiHeadersApiFootball,
      );

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw const LivescoreGetTeamsScoreboardException();
    }
  }

  /// Gets the live match by [teamId]
  Future<Map<String, dynamic>> getLiveMatchByTeam(int teamId) async {
    final url = '$_baseUrlApiFootball/v3/fixtures?season=$_year&team=$teamId';

    try {
      final response = await _httpClient.get(
        Uri.parse(url),
        headers: _apiHeadersApiFootball,
      );

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw const LivescoreGetLiveMatchByTeamException();
    }
  }
}
