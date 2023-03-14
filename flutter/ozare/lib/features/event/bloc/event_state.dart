part of 'event_bloc.dart';

enum EventStatus { loading, success, failure }

class EventState extends Equatable {
  const EventState({
    required this.event,
    this.status = EventStatus.loading,
    this.isLive = true,
  });

  final EventStatus status;
  final livescore.Event event;
  final bool isLive;

  EventState copyWith({
    EventStatus? status,
    livescore.Event? event,
    bool? isLive,
  }) {
    return EventState(
      status: status ?? this.status,
      event: event ?? this.event,
      isLive: isLive ?? this.isLive,
    );
  }

  @override
  List<Object> get props => [status, isLive, event];
}
