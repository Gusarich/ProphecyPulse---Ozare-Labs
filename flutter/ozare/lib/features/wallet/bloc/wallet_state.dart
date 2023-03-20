part of 'wallet_bloc.dart';

enum WalletStatus { initial, loading, success }

enum BetStatus { createdEvent, startedEvent, finishedEvent, placedBet, none }

class WalletState extends Equatable {
  const WalletState({
    this.payload = const Payload(
      from: 'ozare',
      type: '',
      uid: 0,
    ),
    this.response = const Response(
      status: '',
      message: '',
      data: <dynamic>{},
    ),
    this.status = WalletStatus.initial,
    this.betStatus = BetStatus.none,
  });

  final Payload payload;
  final Response response;
  final WalletStatus status;
  final BetStatus betStatus;

  WalletState copyWith({
    Payload? payload,
    Response? response,
    WalletStatus? status,
    BetStatus? betStatus,
  }) {
    return WalletState(
      payload: payload ?? this.payload,
      response: response ?? this.response,
      status: status ?? this.status,
      betStatus: betStatus ?? this.betStatus,
    );
  }

  @override
  List<Object?> get props => [payload, status, response];
}
