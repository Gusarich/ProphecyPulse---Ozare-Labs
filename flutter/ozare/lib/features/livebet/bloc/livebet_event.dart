part of 'livebet_bloc.dart';

abstract class LiveBetEvent extends Equatable {
  const LiveBetEvent();

  @override
  List<Object> get props => [];
}

class LiveBetsRequested extends LiveBetEvent {
  const LiveBetsRequested();
}

class LiveBetsUpdated extends LiveBetEvent {
  const LiveBetsUpdated();

  @override
  List<Object> get props => [];
}
