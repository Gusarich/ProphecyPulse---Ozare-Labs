import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:livescore_api/src/exceptions/exceptions.dart';

/// The LivescoreApiClient class is responsible for making HTTP requests to
/// the Livescore API and the API-Football API, handling responses and
/// providing the data to the application.
class LivescoreApiClient {
  final _baseUrlLivescore = 'https://livescore6.p.rapidapi.com';
  final _baseUrlApiFootball = 'https://api-football-v1.p.rapidapi.com';

  /// Base URL for logo images.
  static const String logoBaseUrl =
      'https://lsm-static-prod.livescore.com/medium/';

  final http.Client _httpClient;
  final _year = DateTime.now().year - 1;

  final _apiHeadersLivescore = {
    'x-rapidapi-host': 'livescore6.p.rapidapi.com',
    'x-rapidapi-key': '07585b4120mshbc941a57c6ebd11p11de9bjsn089233df6ab2',
  };

  final _apiHeadersApiFootball = {
    'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
    'x-rapidapi-key': '07585b4120mshbc941a57c6ebd11p11de9bjsn089233df6ab2',
  };

  /// Creates a new instance of the LivescoreApiClient class.
  ///
  /// Takes an optional [httpClient] parameter, which defaults to a new
  /// instance of the [http.Client] class.
  LivescoreApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  // -----------------------------
  // Livescore API Methods
  // -----------------------------

  /// Fetches leagues from the Livescore API for the given [category].
  ///
  /// Returns a [Map<String, dynamic>] containing the league data.
  Future<Map<String, dynamic>> getLeagues(String category) async {
    return _defaultLeagues(category);
  }

  Future<Map<String, dynamic>> _defaultLeagues(String category) async {
    final _scheduleDate = DateFormat('yyyyMMdd')
        .format(DateTime.now().add(const Duration(days: 1)));
    log(_scheduleDate);
    final url =
        '$_baseUrlLivescore/matches/v2/list-by-date?Category=$category&Date=$_scheduleDate';

    final response = await _httpClient.get(
      Uri.parse(url),
      headers: _apiHeadersLivescore,
    );

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return data;
  }

  /// Fetches the event scoreboard for a given [eid] and [category].
  ///
  /// Returns a [Map<String, dynamic>] containing the event scoreboard data.
  Future<Map<String, dynamic>> getEventScoreboard({
    required String eid,
    required String category,
  }) async {
    final url =
        '$_baseUrlLivescore/matches/v2/get-scoreboard?category=$category&Eid=$eid';

    final response = await _httpClient.get(
      Uri.parse(url),
      headers: _apiHeadersLivescore,
    );

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  // -----------------------------
  // API-Football API Methods
  // -----------------------------

  /// Searches for a team using the provided [query].
  ///
  /// Returns a [Map<String, dynamic>] containing the team data.
  Future<Map<String, dynamic>> getTeams(String query) async {
    final url = '$_baseUrlApiFootball/v3/teams?search=$query';

    final response = await _httpClient.get(
      Uri.parse(url),
      headers: _apiHeadersApiFootball,
    );

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  /// Fetches a live match for the given [teamId].
  ///
  /// Returns a [Map<String, dynamic>] containing the live match data.
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
