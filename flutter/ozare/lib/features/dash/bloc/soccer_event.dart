part of 'soccer_bloc.dart';

abstract class SoccerEvent extends Equatable {
  const SoccerEvent();

  @override
  List<Object> get props => [];
}

class SoccerLeaguesRequested extends SoccerEvent {
  const SoccerLeaguesRequested({required this.isNew});
  final bool isNew;

  @override
  List<Object> get props => [isNew];
}

class SoccerToggleLive extends SoccerEvent {
  const SoccerToggleLive();

  @override
  List<Object> get props => [];
}
