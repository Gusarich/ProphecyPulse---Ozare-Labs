part of 'cricket_bloc.dart';

enum CricketStatus { loading, success, failure }

class CricketState extends Equatable {
  const CricketState({
    required this.leagues,
    this.status = CricketStatus.loading,
    this.message = '',
    this.isLive = true,
  });

  final List<League> leagues;
  final CricketStatus status;
  final String message;
  final bool isLive;

  @override
  List<Object> get props => [leagues, status, message, isLive];

  CricketState copyWith({
    List<League>? leagues,
    CricketStatus? status,
    String? message,
    bool? isLive,
  }) {
    return CricketState(
      leagues: leagues ?? this.leagues,
      status: status ?? this.status,
      message: message ?? this.message,
      isLive: isLive ?? this.isLive,
    );
  }
}
