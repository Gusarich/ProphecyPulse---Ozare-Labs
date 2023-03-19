part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}

class CreateEventRequested extends WalletEvent {
  CreateEventRequested(this.payload);

  final Payload payload;
}

class StartEventRequested extends WalletEvent {
  StartEventRequested(this.payload);

  final Payload payload;
}

class FinishEventRequested extends WalletEvent {
  FinishEventRequested(this.payload);

  final Payload payload;
}

class PlaceBetRequested extends WalletEvent {
  PlaceBetRequested(this.payload);

  final Payload payload;
}
