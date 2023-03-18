part of 'search_bloc.dart';

enum SearchStatus { none, loading, succeed, failure, fixtures }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.none,
    this.teams = const [],
    this.message = '',
    this.query = '',
    this.category = '',
    this.fixtures = const [],
    this.team,
  });

  final List<Fixture> fixtures;
  final SearchStatus status;
  final List<Team> teams;
  final String message;
  final String query;
  final String category;
  final Team? team;

  SearchState copyWith({
    SearchStatus? status,
    List<Team>? teams,
    String? message,
    String? query,
    String? category,
    List<Fixture>? fixtures,
    Team? team,
  }) {
    return SearchState(
      teams: teams ?? this.teams,
      status: status ?? this.status,
      message: message ?? this.message,
      query: query ?? this.query,
      category: category ?? this.category,
      fixtures: fixtures ?? this.fixtures,
      team: team ?? this.team,
    );
  }

  @override
  List<Object> get props => [status, teams, message, query, category, fixtures];
}
