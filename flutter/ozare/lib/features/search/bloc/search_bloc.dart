import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescore_repository/livescore_repository.dart';
import 'package:ozare_repository/ozare_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required SearchRepository repository,
  })  : _repo = repository,
        super(const SearchState()) {
    on<SearchRequested>(_onSearchRequested);
    on<SearchStatusChanged>(_onSearchStatusChanged);
    on<SearchTeamMatchRequested>(_onSearchTeamMatchRequested);
    on<SearchScheduleBackPressed>(_onSearchScheduleBackPressed);
  }

  final SearchRepository _repo;

  // Event Handlers
  void _onSearchStatusChanged(
    SearchStatusChanged event,
    Emitter<SearchState> emit,
  ) {
    emit(const SearchState(status: SearchStatus.none, query: '', fixtures: []));
  }

  void _onSearchScheduleBackPressed(
    SearchScheduleBackPressed event,
    Emitter<SearchState> emit,
  ) {
    emit(
      state.copyWith(
        status: SearchStatus.succeed,
        fixtures: [],
        team: null,
      ),
    );
  }

  Future<void> _onSearchTeamMatchRequested(
    SearchTeamMatchRequested event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: SearchStatus.loading));
    var fixtures = <Fixture>[];
    if (event.category.contains('soccer')) {
      fixtures = await _repo.getLiveMatchByTeam(event.team.id);
    } else {
      fixtures = await _repo.getScheduleMatchByCategory(
        event.team.id,
        event.category,
      );
    }
    emit(
      state.copyWith(
        status: SearchStatus.fixtures,
        fixtures: fixtures,
        team: event.team,
      ),
    );
  }

  Future<void> _onSearchRequested(
    SearchRequested event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SearchStatus.loading,
        category: event.searchCategory,
      ),
    );

    var teams = <Team>[];
    //FIXME - Add category upon searching.
    try {
      if (event.searchCategory.contains('soccer')) {
        teams = await _repo.getTeams(event.query);
      } else {
        teams = await _repo.searchTeamsByCategory(
          event.query,
          event.searchCategory,
        );
      }

      if (teams.isNotEmpty) {
        emit(
          state.copyWith(
            status: SearchStatus.succeed,
            teams: teams,
            query: event.query,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: SearchStatus.none,
            message:
                'No Teams found for ${event.query} on ${event.searchCategory}',
            query: event.query,
          ),
        );
      }
    } catch (error) {
      // emit(
      //   state.copyWith(
      //     status: SearchStatus.failure,
      //     message: error.toString(),
      //   ),
      // );
      emit(
        state.copyWith(
          status: SearchStatus.none,
          message:
              'No Teams found for ${event.query} on ${event.searchCategory}',
          query: event.query,
        ),
      );
    }
  }
}
