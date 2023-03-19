import 'package:livescore_repository/livescore_repository.dart';

class SearchRepository {
  SearchRepository({required LivescoreRepository livescoreRepository})
      : _livescoreRepository = livescoreRepository;

  final LivescoreRepository _livescoreRepository;

  Future<List<Team>> getTeams(String query) async {
    final teams = await _livescoreRepository.getSoccerTeams(query);
    teams.sort((a, b) => a.name.compareTo(b.name));
    return teams;
  }

  Future<List<Team>> searchTeamsByCategory(
      String query, String category) async {
    final teams = await _livescoreRepository.searchTeamsByCategory(
      query,
      category,
    );
    teams.sort((a, b) => a.name.compareTo(b.name));
    return teams;
  }

  Future<List<Fixture>> getLiveMatchByTeam(int teamId) async {
    final fixture = await _livescoreRepository.getLiveMatchByTeam(teamId);

    fixture.sort((a, b) => a.date.compareTo(b.date));
    return fixture;
  }

  Future<List<Fixture>> getScheduleMatchByCategory(
      int teamId, String category) async {
    final fixture =
        await _livescoreRepository.getScheduleMatchByCategory(teamId, category);

    fixture.sort((a, b) => a.date.compareTo(b.date));
    return fixture;
  }
}
