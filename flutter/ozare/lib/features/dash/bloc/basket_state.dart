part of 'basket_bloc.dart';

enum BasketStatus { loading, success, failure }

class BasketState extends Equatable {
  const BasketState({
    required this.leagues,
    this.status = BasketStatus.loading,
    this.message = '',
    this.isLive = true,
  });

  final List<League> leagues;
  final BasketStatus status;
  final String message;
  final bool isLive;

  @override
  List<Object> get props => [leagues, status, message, isLive];

  BasketState copyWith({
    List<League>? leagues,
    BasketStatus? status,
    String? message,
    bool? isLive,
  }) {
    return BasketState(
      leagues: leagues ?? this.leagues,
      status: status ?? this.status,
      message: message ?? this.message,
      isLive: isLive ?? this.isLive,
    );
  }
}
