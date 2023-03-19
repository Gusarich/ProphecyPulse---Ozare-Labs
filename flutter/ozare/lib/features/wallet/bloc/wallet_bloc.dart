import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ozare/features/wallet/models/models.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(const WalletState()) {
    on<CreateEventRequested>(_onCreateEventRequested);
    on<StartEventRequested>(_onStartEventRequested);
    on<FinishEventRequested>(_onFinishEventRequested);
    on<PlaceBetRequested>(_onPlaceBetRequested);
  }

  Future<void> _onCreateEventRequested(
    CreateEventRequested event,
    Emitter<WalletState> emit,
  ) async {
    emit(state.copyWith(status: WalletStatus.loading));

    try {
      emit(
        state.copyWith(
          payload: event.payload,
          betStatus: BetStatus.createdEvent,
        ),
      );
      emit(state.copyWith(status: WalletStatus.success));
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _onStartEventRequested(
    StartEventRequested event,
    Emitter<WalletState> emit,
  ) async {

    try {
      emit(
        state.copyWith(
          status: WalletStatus.loading,
          betStatus: BetStatus.startedEvent,
        ),
      );
      emit(state.copyWith(status: WalletStatus.success));
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _onFinishEventRequested(
    FinishEventRequested event,
    Emitter<WalletState> emit,
  ) async {
    emit(
      state.copyWith(
        status: WalletStatus.loading,
        betStatus: BetStatus.finishedEvent,
      ),
    );

    try {} catch (_) {
      rethrow;
    }
  }

  Future<void> _onPlaceBetRequested(
    PlaceBetRequested event,
    Emitter<WalletState> emit,
  ) async {
    emit(
      state.copyWith(
        status: WalletStatus.loading,
        betStatus: BetStatus.placedBet,
      ),
    );

    try {} catch (_) {
      rethrow;
    }
  }

}
