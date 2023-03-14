part of 'bet_bloc.dart';

abstract class BetEvent extends Equatable {
  const BetEvent();

  @override
  List<Object> get props => [];
}

class BetCreated extends BetEvent {
  const BetCreated(this.bet, this.event);

  final ozare.Bet bet;
  final Map<String, dynamic> event;

  @override
  List<Object> get props => [bet, event];
}

class BetsUpdated extends BetEvent {
  const BetsUpdated(this.bets);

  final List<ozare.Bet> bets;

  @override
  List<Object> get props => [bets];
}

class BetSubscriptionRequested extends BetEvent {
  const BetSubscriptionRequested();

  @override
  List<Object> get props => [];
}
