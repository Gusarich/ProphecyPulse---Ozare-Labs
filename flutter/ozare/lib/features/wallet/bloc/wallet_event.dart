part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}

class CreateEventRequested extends WalletEvent {
  CreateEventRequested(this.payload, this.bet, this.event);

  final Payload payload;
  final Bet bet;
  final Map<String, dynamic> event;
}

class PayloadSubmitted extends WalletEvent {
  PayloadSubmitted(this.response);
  final Response response;
}
