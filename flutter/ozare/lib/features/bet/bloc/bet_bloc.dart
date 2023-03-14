// ignore_for_file: depend_on_referenced_packages

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescore_repository/livescore_repository.dart';
import 'package:ozare_repository/ozare_repository.dart' as ozare;

part 'bet_event.dart';
part 'bet_state.dart';

class BetBloc extends Bloc<BetEvent, BetState> {
  BetBloc({
    required ozare.BetRepository betRepository,
    required this.eventId,
  })  : _betRepository = betRepository,
        super(const BetState()) {
    on<BetCreated>(_onBetCreated);
    on<BetSubscriptionRequested>(_onSubscriptionRequested);
    on<BetsUpdated>(_onBetsUpdated);
  }

  final ozare.BetRepository _betRepository;
  final String eventId;

  /// EVENT HANDLERS
  /// [BetCreated] event handler
  Future<void> _onBetCreated(
    BetCreated event,
    Emitter<BetState> emit,
  ) async {
    final bet =
        state.bets.firstWhereOrNull((b) => b.userId == event.bet.userId);

    if (bet != null) {
      emit(state.copyWith(betStatus: CreateBetStatus.exists));
    } else {
      await _betRepository.createBet(
        bet: event.bet,
      );
      emit(
        state.copyWith(
          status: BetStatus.success,
          betStatus: CreateBetStatus.created,
        ),
      );
    }
  }

  /// [BetsUpdated] event handler
  /// This event is triggered when the bets are updated

  void _onBetsUpdated(
    BetsUpdated event,
    Emitter<BetState> emit,
  ) {
    emit(state.copyWith(bets: event.bets, status: BetStatus.success));
  }

  /// Bet Stream
  Future<void> _onSubscriptionRequested(
    BetSubscriptionRequested event,
    Emitter<BetState> emit,
  ) async {
    await emit.forEach(
      _betRepository.betStream(eventId),
      onData: (bets) => state.copyWith(
        bets: bets,
        status: BetStatus.success,
      ),
      onError: (error, _) {
        return state.copyWith(
          status: BetStatus.failure,
        );
      },
    );
  }
}
