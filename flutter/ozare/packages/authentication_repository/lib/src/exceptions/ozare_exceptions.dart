/// Thrown when ozare api fails.
class OzareException implements Exception {
  /// Thrown when ozare api fails.
  const OzareException(this.errorMessage);

  final String errorMessage;
}

/// Thrown when fails to get owner.
class OzareGetOwnerException extends OzareException {
  /// Thrown when fails to get owner.
  const OzareGetOwnerException(super.errorMessage);
}

/// Thrown when fails to sign up user.
class OzareSignUpWithEmailAndPasswordFailure extends OzareException {
  /// Thrown when fails to sign up user.
  const OzareSignUpWithEmailAndPasswordFailure(super.errorMessage);
}

/// Thrown when fails to logout.
class OzareLogOutFailure extends OzareException {
  /// Thrown when fails to logout.
  const OzareLogOutFailure(super.errorMessage);
}

/// Thrown when fails to sign in with google.
class OzareSignWithGoogleException extends OzareException {
  /// Thrown when fails to sign in with google.
  const OzareSignWithGoogleException(super.errorMessage);
}

/// Thrown when fails to sign in anonymously.
class OzareSignAnonymouslyException extends OzareException {
  /// Thrown when fails to sign in anonymously.
  const OzareSignAnonymouslyException(super.errorMessage);
}
