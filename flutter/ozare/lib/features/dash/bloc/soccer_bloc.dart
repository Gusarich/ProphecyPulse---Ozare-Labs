// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescore_repository/livescore_repository.dart';
import 'package:ozare_repository/ozare_repository.dart';

part 'soccer_event.dart';
part 'soccer_state.dart';

class SoccerBloc extends Bloc<SoccerEvent, SoccerState> {
  SoccerBloc({
    required LivescoreRepository livescoreRepository,
    required DashRepository dashRepository,
  })  : _livescoreRepository = livescoreRepository,
        _dashRepository = dashRepository,
        super(const SoccerState(leagues: [])) {
    on<SoccerLeaguesRequested>(_onSoccerLeaguesRequested);
    on<SoccerToggleLive>(_onSoccerToggleLive);
  }

  final LivescoreRepository _livescoreRepository;
  final DashRepository _dashRepository;

  /// Event handler for SoccerLeaguesRequested
  Future<void> _onSoccerLeaguesRequested(
    SoccerLeaguesRequested event,
    Emitter<SoccerState> emit,
  ) async {
    try {
      emit(state.copyWith(status: SoccerStatus.loading, message: 'Loading...'));
      var leagues = <League>[];

      //Gets the existing data from the database.
      final leagueData = await _dashRepository.getLeagues(
        'soccer',
        refresherInMinutes: 60,
      );

      if (leagueData == null) {
        //Leagues from livescore
        final leaguesOnApi = await _livescoreRepository.getLeagues(
          'soccer',
        );

        leagues = leaguesOnApi;
        //Saves it to firestore
        await _dashRepository.saveLeagues('soccer', leagues);
      } else {
        leagues = leagueData;
      }

      emit(
        SoccerState(
          leagues: leagues,
          status: SoccerStatus.success,
          message: 'success',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SoccerStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  /// Event handler for SoccerToggleLive
  Future<void> _onSoccerToggleLive(
    SoccerToggleLive event,
    Emitter<SoccerState> emit,
  ) async {
    emit(state.copyWith(isLive: !state.isLive));

    if (state.isLive) {
      await Future.delayed(const Duration(seconds: 8));
      add(const SoccerLeaguesRequested(isNew: false));
    }
  }
}
