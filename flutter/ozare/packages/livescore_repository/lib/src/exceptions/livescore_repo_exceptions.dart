/// Thrown when livescore repository fails.
abstract class LivescoreRepoException implements Exception {
  /// Thrown when livescore repository fails.
  const LivescoreRepoException([this.errorMessage]);

  /// error message.
  final String? errorMessage;
}

/// Thrown when parse events fails.
class LivescoreRepoParseEventsException extends LivescoreRepoException {
  /// Thrown when parse events fails.
  const LivescoreRepoParseEventsException([super.errorMessage]);
}

/// Thrown when parse events fails.
class LivescoreRepoGetLeaguesException extends LivescoreRepoException {
  /// Thrown when parse events fails.
  const LivescoreRepoGetLeaguesException([super.errorMessage]);
}

/// Thrown when get live match by team fails.
class LivescoreRepoGetLiveMatchByTeamException extends LivescoreRepoException {
  /// Thrown when get live match by team fails.
  const LivescoreRepoGetLiveMatchByTeamException([super.errorMessage]);
}
