// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescore_repository/livescore_repository.dart';
import 'package:ozare_repository/ozare_repository.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc({
    required LivescoreRepository livescoreRepository,
    required DashRepository dashRepository,
  })  : _livescoreRepository = livescoreRepository,
        _dashRepository = dashRepository,
        super(const BasketState(leagues: [])) {
    on<BasketLeaguesRequested>(_onBasketLeaguesRequested);
    on<BasketToggleLive>(_onBasketToggleLive);
  }

  final LivescoreRepository _livescoreRepository;
  final DashRepository _dashRepository;

  int callCounter = 0;

  /// Event handler for BasketLeaguesRequested
  Future<void> _onBasketLeaguesRequested(
    BasketLeaguesRequested event,
    Emitter<BasketState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BasketStatus.loading, message: 'Loading...'));
      var leagues = <League>[];

      //Gets the existing data from the database.
      final leagueData = await _dashRepository.getLeagues(
        'basketball',
        refresherInMinutes: 60,
      );

      if (leagueData == null) {
        final leaguesOnApi = await _livescoreRepository.getLeagues(
          'basketball',
        );

        leagues = leaguesOnApi;
        //Saves it to firestore
        await _dashRepository.saveLeagues('basketball', leagues);
      } else {
        leagues = leagueData;
      }

      emit(
        BasketState(
          leagues: leagues,
          status: BasketStatus.success,
          message: 'success',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: BasketStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  /// Event handler for BasketToggleLive
  Future<void> _onBasketToggleLive(
    BasketToggleLive event,
    Emitter<BasketState> emit,
  ) async {
    emit(state.copyWith(isLive: !state.isLive));
    if (state.isLive) {
      await Future.delayed(const Duration(seconds: 8));
      add(const BasketLeaguesRequested(isNew: false));
    }
  }
}
