// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart'
    as auth;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required auth.OzareRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthLoading(message: 'Initializing ...')) {
    on<AuthCheckRequested>(_onAuthCheckRequestedToState);
    on<AuthLanguageRequested>(_onAuthCheckLanguage);
    on<AuthLoginRequested>(_onAuthLoginRequestedToState);
    on<AuthOnboardingCompleted>(_onAuthOnboardingCompletedToState);
    on<AuthSignUpRequested>(_onAuthSignUpRequestedToState);
    on<AuthSignUpPageRequested>(_onAuthSignUpPageRequestedToState);
    on<AuthLoginPageRequested>(_onAuthLoginPageRequestedToState);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthGoogleLoginRequested>(_onAuthGoogleLoginRequested);
  }

  final auth.OzareRepository _authRepository;

  Future<void> _onAuthCheckRequestedToState(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading(message: 'Checking onboard status ...'));
      final isOnBoarded = _authRepository.getLocalOnboardStatus();
      if (isOnBoarded != null && isOnBoarded) {
        final oUser = auth.OUser.fromJson(_authRepository.getLocalOwner()!);
        if (oUser != null) {
          emit(AuthLoggedIn(oUser: oUser));
        } else {
          emit(const AuthInitial());
        }
      } else {
        emit(const AuthOnboarding());
      }
    } catch (_) {
      emit(const AuthOnboarding());
    }
  }

  Future<void> _onAuthCheckLanguage(
    AuthLanguageRequested event,
    Emitter<AuthState> emit,
  ) async {
    // try {
    //   emit(const AuthBloc(authRepository: 'Loading Language ...'));

    // }
  }

  Future<void> _onAuthOnboardingCompletedToState(
    AuthOnboardingCompleted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Saving onboard status ...'));

    await _authRepository.saveLocalOnboardStatus(status: true);
    emit(const AuthInitial());
  }

  Future<void> _onAuthLoginRequestedToState(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading(message: 'Logging in ...'));

      final oUser = await _authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      await _authRepository.setLocalOwner(oUser.toJson());

      emit(AuthLoggedIn(oUser: oUser));
    } catch (_) {
      emit(const AuthFailure(message: 'Wrong credentials entered'));
      emit(const AuthInitial());
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading(message: 'Logging out ...'));
      await _authRepository.clearLocalOwner();
      await _authRepository.signOut();
    } catch (_) {
      emit(const AuthFailure(message: 'Failed to sign out'));
      emit(const AuthInitial());
    }
  }

  Future<void> _onAuthSignUpRequestedToState(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading(message: 'Creating your account ...'));

      final oUser = await _authRepository.signUpWithEmailAndPassword(
        oUser: auth.OUser.fromJson(event.oUser),
        password: event.password,
      );
      await _authRepository.setLocalOwner(oUser.toJson());
      emit(AuthLoggedIn(oUser: oUser));
    } catch (_) {
      emit(const AuthFailure(message: 'Failed to sign up'));

      emit(const AuthInitial());
    }
  }

  Future<void> _onAuthSignUpPageRequestedToState(
    AuthSignUpPageRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthSignUp());
  }

  Future<void> _onAuthLoginPageRequestedToState(
    AuthLoginPageRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthInitial());
  }

  Future<void> _onAuthGoogleLoginRequested(
    AuthGoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading(message: 'Logging in ...'));

      final oUser = await _authRepository.signInWithGoogle();
      await _authRepository.setLocalOwner(oUser.toJson());

      emit(AuthLoggedIn(oUser: oUser));
    } catch (e) {
      emit(const AuthFailure(message: 'Failed to login with Google'));

      emit(const AuthInitial());
    }
  }

}
