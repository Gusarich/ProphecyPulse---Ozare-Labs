part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchRequested extends SearchEvent {
  const SearchRequested(this.query);

  final String query;

  @override
  List<Object> get props => [query];
}

class SearchStatusChanged extends SearchEvent {
  const SearchStatusChanged(this.status);

  final SearchStatus status;

  @override
  List<Object?> get props => [status];
}

class SearchTeamMatchRequested extends SearchEvent {
  const SearchTeamMatchRequested(this.team);

  final Team team;

  @override
  List<Object> get props => [team];
}

class SearchScheduleBackPressed extends SearchEvent {
  const SearchScheduleBackPressed();

  @override
  List<Object> get props => [];
}
