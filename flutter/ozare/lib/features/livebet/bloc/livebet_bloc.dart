// ignore_for_file: depend_on_referenced_packages

import 'package:authentication_repository/authentication_repository.dart'
    as auth;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare_repository/ozare_repository.dart';

part 'livebet_event.dart';
part 'livebet_state.dart';

class LiveBetBloc extends Bloc<LiveBetEvent, LiveBetState> {
  LiveBetBloc({
    required LiveBetRepository liveBetRepository,
    required auth.OzareRepository authRepository,
  })  : _livescoreRepository = liveBetRepository,
        super(const LiveBetState()) {
    oUser = OUser.fromJson(authRepository.getLocalOwner()!);
    on<LiveBetsRequested>(_onLiveBetsRequested);
    on<LiveBetsUpdated>(_onLiveBetsUpdated);
  }

  final LiveBetRepository _livescoreRepository;
  late OUser oUser;

  /// This method is called when the LiveBetsRequested event is added.
  Future<void> _onLiveBetsRequested(
    LiveBetsRequested event,
    Emitter<LiveBetState> emit,
  ) async {
    await emit.forEach(
      _livescoreRepository.liveBetStream(oUser.uid!),
      onData: (bets) => state.copyWith(liveBets: bets),
    );
  }

  /// This method is called when the LiveBetsUpdated event is added.
  Future<void> _onLiveBetsUpdated(
    LiveBetsUpdated event,
    Emitter<LiveBetState> emit,
  ) async {
    while (true) {
      await _livescoreRepository.updatesBet(oUser.uid!);

      await Future.delayed(const Duration(minutes: 10));
    }
  }
}
