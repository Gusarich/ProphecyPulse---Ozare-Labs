import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/auth/bloc/auth_bloc.dart';
import 'package:ozare/features/auth/view/signIn_page.dart';
import 'package:ozare/features/auth/view/signUp_page.dart';
import 'package:ozare/features/home/home.dart';
import 'package:ozare/features/onboard/view/onboard_page.dart';
import 'package:ozare/features/wallet/view/view.dart';
import 'package:ozare/styles/common/common.dart';
import 'package:ozare/styles/common/widgets/dialogs/dialogs.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        log('AuthBloc State in Builder: ${state.runtimeType}');

        if (state is AuthFailure) {
          showAlertDialog(
            context: context,
            title: 'Failure',
            content: state.message,
          );
        }
      },
      builder: (context, state) {
        log('AuthBloc State in Builder: ${state.runtimeType}');
        if (state is AuthOnboarding) {
          return const OnboardPage();
        } else if (state is AuthLoading) {
          return Loader(message: state.message);
        } else if (state is AuthInitial) {
          return const SignInPage();
        } else if (state is AuthSignUp) {
          return const SignUpPage();
        } else if (state is AuthLoggedIn) {
          return const HomePage();
        }

        return const Loader(message: 'Loading...');
      },
    );
  }
}
