part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthOnboarding extends AuthState {
  const AuthOnboarding();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  const AuthLoading({
    required this.message,
  });
  final String message;

  @override
  List<Object> get props => [message];
}

class AuthSignUp extends AuthState {
  const AuthSignUp();

  @override
  List<Object> get props => [];
}


class AuthLoggedIn extends AuthState {
  const AuthLoggedIn({
    required this.oUser,
  });

  final auth.OUser oUser;

  @override
  List<Object> get props => [oUser];
}

class AuthFailure extends AuthState {
  const AuthFailure({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}
