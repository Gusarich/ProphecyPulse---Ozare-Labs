/// Thrown when livescore fails.
class LivescoreException implements Exception {
  /// Thrown when livescore fails.
  const LivescoreException([this.errorMessage]);
  final String? errorMessage;
}

/// Thrown when get leagues fails.
class LivescoreGetLeaguesException extends LivescoreException {
  /// Thrown when get leagues fails.
  const LivescoreGetLeaguesException([super.errorMessage]);
}

/// Thrown when get event scoreboard fails.
class LivescoreGetEventScoreboardException extends LivescoreException {
  /// Thrown when get event scoreboard fails.
  const LivescoreGetEventScoreboardException([super.errorMessage]);
}

/// Thrown when get teams fails.
class LivescoreGetTeamsScoreboardException extends LivescoreException {
  /// Thrown when get teams fails.
  const LivescoreGetTeamsScoreboardException([super.errorMessage]);
}

/// Thrown when get live match by team fails.
class LivescoreGetLiveMatchByTeamException extends LivescoreException {
  /// Thrown when get live match by team fails.
  const LivescoreGetLiveMatchByTeamException([super.errorMessage]);
}
