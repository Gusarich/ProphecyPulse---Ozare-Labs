part of 'cricket_bloc.dart';

abstract class CricketEvent extends Equatable {
  const CricketEvent();

  @override
  List<Object> get props => [];
}

class CricketLeaguesRequested extends CricketEvent {
  const CricketLeaguesRequested({required this.isNew});
  final bool isNew;

  @override
  List<Object> get props => [isNew];
}

class CricketToggleLive extends CricketEvent {
  const CricketToggleLive();

  @override
  List<Object> get props => [];
}
