import 'package:livescore_repository/livescore_repository.dart';

class SearchRepository {
  SearchRepository({required LivescoreRepository livescoreRepository})
      : _livescoreRepository = livescoreRepository;

  final LivescoreRepository _livescoreRepository;

  Future<List<Team>> getTeams(String query) async {
    final teams = await _livescoreRepository.getTeams(query);
    return teams;
  }

  Future<List<Fixture>> getLiveMatchByTeam(int teamId) async {
    final fixture = await _livescoreRepository.getLiveMatchByTeam(teamId); 

    return fixture;
  }
}
