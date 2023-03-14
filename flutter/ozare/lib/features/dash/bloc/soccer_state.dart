part of 'soccer_bloc.dart';

enum SoccerStatus { loading, success, failure }

class SoccerState extends Equatable {
  const SoccerState({
    required this.leagues,
    this.status = SoccerStatus.loading,
    this.message = '',
    this.isLive = true,
  });

  final List<League> leagues;
  final SoccerStatus status;
  final String message;
  final bool isLive;

  @override
  List<Object> get props => [leagues, status, message, isLive];

  SoccerState copyWith({
    List<League>? leagues,
    SoccerStatus? status,
    String? message,
    bool? isLive,
  }) {
    return SoccerState(
      leagues: leagues ?? this.leagues,
      status: status ?? this.status,
      message: message ?? this.message,
      isLive: isLive ?? this.isLive,
    );
  }
}
