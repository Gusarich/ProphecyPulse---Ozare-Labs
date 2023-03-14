// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescore_repository/livescore_repository.dart';
import 'package:ozare_repository/ozare_repository.dart';

part 'cricket_event.dart';
part 'cricket_state.dart';

class CricketBloc extends Bloc<CricketEvent, CricketState> {
  CricketBloc({
    required LivescoreRepository livescoreRepository,
    required DashRepository dashRepository,
  })  : _livescoreRepository = livescoreRepository,
        _dashRepository = dashRepository,
        super(const CricketState(leagues: [])) {
    on<CricketLeaguesRequested>(_onCricketLeaguesRequested);
    on<CricketToggleLive>(_onCricketToggleLive);
  }

  final LivescoreRepository _livescoreRepository;
  final DashRepository _dashRepository;

  /// Event handler for CricketLeaguesRequested
  Future<void> _onCricketLeaguesRequested(
    CricketLeaguesRequested event,
    Emitter<CricketState> emit,
  ) async {
    try {
      emit(
          state.copyWith(status: CricketStatus.loading, message: 'Loading...'));
      var leagues = <League>[];

      //Gets the existing data from the database.
      final leagueData = await _dashRepository.getLeagues(
        'cricket',
        refresherInMinutes: 60,
      );

      if (leagueData == null) {
        //Leagues from livescore
        final leaguesOnApi = await _livescoreRepository.getLeagues(
          'cricket',
        );

        leagues = leaguesOnApi;
        //Saves it to firestore
        await _dashRepository.saveLeagues('cricket', leagues);
      } else {
        leagues = leagueData;
      }

      emit(
        CricketState(
          leagues: leagues,
          status: CricketStatus.success,
          message: 'success',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CricketStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  /// Event handler for CricketToggleLive
  Future<void> _onCricketToggleLive(
    CricketToggleLive event,
    Emitter<CricketState> emit,
  ) async {
    emit(state.copyWith(isLive: !state.isLive));

    if (state.isLive) {
      await Future.delayed(const Duration(seconds: 8));
      add(const CricketLeaguesRequested(isNew: false));
    }
  }
}
