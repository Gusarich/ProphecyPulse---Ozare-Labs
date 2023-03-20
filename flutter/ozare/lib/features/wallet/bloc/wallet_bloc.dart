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
  }

  Future<void> _onCreateEventRequested(
    CreateEventRequested event,
    Emitter<WalletState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          payload: event.payload,
        ),
      );
    } catch (_) {
      rethrow;
    }
  }
}
