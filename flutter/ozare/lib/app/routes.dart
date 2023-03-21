import 'dart:developer';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:ozare/features/auth/auth.dart';
import 'package:ozare/features/bet/bet.dart';
import 'package:ozare/features/dash/view/view.dart';
import 'package:ozare/features/home/home.dart';
import 'package:ozare/features/livebet/livebet.dart';
import 'package:ozare/features/profile/view/view.dart';
import 'package:ozare/features/splash/splash.dart';
import 'package:ozare/features/wallet/view/sign_wallet_page.dart';
import 'package:ozare/features/wallet/view/view.dart';

class Routes {
  static const home = '/';
  static const signUp = 'signUp';
  static const logIn = 'logIn';
  static const splash = 'splash';
  static const auth = 'auth';
  static const onboard = 'onboard';
  static const wallets = '/wallets';
  static const liveBets = '/liveBets';
  static const profile = '/profile';
  static const notifications = '/notifications';
  static const dash = '/dash';
  static const signTransaction = '/signTransaction';
  static const connectWallet = '/connectWallet';

  static String currentRoute = splash;

  static Route<dynamic> onGenerateRouted(RouteSettings routeSettings) {
    //to track current route
    //this will only track pushed route on top of previous route
    currentRoute = routeSettings.name ?? '';
    log('Current Route is $currentRoute');

    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case dash:
        return MaterialPageRoute(builder: (context) => const DashPage());
      case auth:
        return MaterialPageRoute(builder: (context) => const AuthPage());
      case profile:
        return MaterialPageRoute(builder: (context) => const ProfilePage());
      case notifications:
        return MaterialPageRoute(
          builder: (context) => const NotificationsPage(),
        );
      case wallets:
        return MaterialPageRoute(builder: (context) => const PaymentsPage());
      case signTransaction:
        return MaterialPageRoute(
          builder: (context) =>
              SignTransactionPage(betBloc: routeSettings.arguments! as BetBloc),
        );
      case connectWallet:
        return MaterialPageRoute(
          builder: (context) => const ConnectWalletPage(),
        );
      case liveBets:
        return MaterialPageRoute(builder: (context) => const LiveBetsView());

      default:
        return MaterialPageRoute(builder: (context) => const Scaffold());
    }
  }
}
