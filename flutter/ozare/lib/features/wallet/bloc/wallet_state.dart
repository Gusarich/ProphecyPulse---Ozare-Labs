part of 'wallet_bloc.dart';

enum WalletStatus { initial, disconnected, connected }

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
    this.bet = const <String, dynamic>{},
    this.event = const <String, dynamic>{},
  });

  final Payload payload;
  final Response response;
  final WalletStatus status;
  final Map<String, dynamic>? bet;
  final Map<String, dynamic>? event;

  WalletState copyWith({
    Payload? payload,
    Response? response,
    WalletStatus? status,
    Map<String, dynamic>? bet,
    Map<String, dynamic>? event,
  }) {
    return WalletState(
      payload: payload ?? this.payload,
      response: response ?? this.response,
      status: status ?? this.status,
      bet:bet ?? this.bet,
      event:event ?? this.event,
    );
  }

  @override
  List<Object?> get props => [payload, status, response, bet, event];
}
