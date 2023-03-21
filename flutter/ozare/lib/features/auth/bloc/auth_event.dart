part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

class AuthLanguageRequested extends AuthEvent {
  const AuthLanguageRequested();
}

class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthSignUpPageRequested extends AuthEvent {
  const AuthSignUpPageRequested();
}

class AuthSignUpRequested extends AuthEvent {
  const AuthSignUpRequested({
    required this.oUser,
    required this.password,
  });

  final Map<String, dynamic> oUser;
  final String password;

  @override
  List<Object> get props => [oUser, password];
}

class AuthOnboardingCompleted extends AuthEvent {
  const AuthOnboardingCompleted();
}

class AuthLoginPageRequested extends AuthEvent {
  const AuthLoginPageRequested();
}

class AuthGoogleLoginRequested extends AuthEvent {
  const AuthGoogleLoginRequested();
}

class AuthWalletLoginPageRequested extends AuthEvent {
  const AuthWalletLoginPageRequested();
}

class AuthWalletLoginCompleted extends AuthEvent {
  const AuthWalletLoginCompleted({
    required this.oUser,
  });

  final Map<String, dynamic> oUser;

  @override
  List<Object> get props => [oUser];
}
