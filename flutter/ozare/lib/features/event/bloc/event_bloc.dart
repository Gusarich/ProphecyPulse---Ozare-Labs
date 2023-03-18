// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescore_repository/livescore_repository.dart' as livescore;
import 'package:ozare_repository/ozare_repository.dart' as ozare;

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc({
    required ozare.EventRepository eventRepository,
    required livescore.LivescoreRepository livescoreRepository,
  })  : _eventRepository = eventRepository,
        _livescoreRepository = livescoreRepository,
        super(
          const EventState(
            event: livescore.Event(
              category: 'soccer',
              id: '',
              id1: '',
              id2: '',
              score1: '',
              score2: '',
              team1: '',
              team2: '',
              time: '',
              logo1: '',
              logo2: '',
            ),
          ),
        ) {
    on<EventInitializedRequested>(_onEventInitializedRequested);
    on<EventToggleLive>(_onEventToggleLive);
  }

  final ozare.EventRepository _eventRepository;
  final livescore.LivescoreRepository _livescoreRepository;

  /// EventInitializedRequested
  Future<void> _onEventInitializedRequested(
    EventInitializedRequested event,
    Emitter<EventState> emit,
  ) async {
    await _eventRepository.initializeEvent(event.event.toJson());
  }

  /// EventToggleLive
  Future<void> _onEventToggleLive(
    EventToggleLive event,
    Emitter<EventState> emit,
  ) async {
    emit(state.copyWith(isLive: !state.isLive));
  }
}
