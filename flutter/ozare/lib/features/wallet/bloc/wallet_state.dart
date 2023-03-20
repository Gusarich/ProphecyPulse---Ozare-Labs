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
  });

  final Payload payload;
  final Response response;
  final WalletStatus status;

  WalletState copyWith({
    Payload? payload,
    Response? response,
    WalletStatus? status,
  }) {
    return WalletState(
      payload: payload ?? this.payload,
      response: response ?? this.response,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [payload, status, response];
}
