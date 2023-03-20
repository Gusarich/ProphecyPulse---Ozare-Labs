part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}

class CreateEventRequested extends WalletEvent {
  CreateEventRequested({
    required this.payload,
    required this.bet,
    required this.event,
  });

  final Payload payload;
  final Map<String, dynamic> bet;
  final Map<String, dynamic> event;
}

class PayloadSubmitted extends WalletEvent {
  PayloadSubmitted(this.response);
  final Response response;
}
