// ignore_for_file: depend_on_referenced_packages

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescore_api/livescore_api.dart';
import 'package:livescore_repository/livescore_repository.dart';
import 'package:local_api/local_api.dart' as local;
import 'package:ozare/app/routes.dart';
import 'package:ozare/features/auth/bloc/auth_bloc.dart';
import 'package:ozare/features/dash/bloc/basket_bloc.dart';
import 'package:ozare/features/dash/bloc/cricket_bloc.dart';
import 'package:ozare/features/dash/bloc/soccer_bloc.dart';
import 'package:ozare/features/event/event.dart';
import 'package:ozare/features/home/home.dart';
import 'package:ozare/features/livebet/livebet.dart';
import 'package:ozare/features/profile/profile.dart';
import 'package:ozare/features/search/search.dart';
import 'package:ozare/features/splash/view/splash_page.dart';
import 'package:ozare/features/wallet/bloc/wallet_bloc.dart';
import 'package:ozare/l10n/l10n.dart';
import 'package:ozare_repository/ozare_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locale = Locale('en');

class App extends StatelessWidget {
  const App({
    required this.firebaseFirestore,
    required this.firebaseStorage,
    required this.livescoreClientApi,
    required this.sharedPreferences,
    required this.localLivescoreClient,
    super.key,
  });

  final FirebaseFirestore firebaseFirestore;
  final LivescoreApiClient livescoreClientApi;
  final local.LivescoreApi localLivescoreClient;
  final FirebaseStorage firebaseStorage;
  final SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OzareRepository>(
          create: (context) => OzareRepository(
            firestore: firebaseFirestore,
            authClient: local.AuthClient(sharedPreferences: sharedPreferences),
          ),
        ),
        RepositoryProvider<LivescoreRepository>(
          create: (context) => LivescoreRepository(
            livescoreApiClient: livescoreClientApi,
            localLivescoreClient: localLivescoreClient,
          ),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepository(
            firestore: firebaseFirestore,
            storage: firebaseStorage,
          ),
        ),
        RepositoryProvider<EventRepository>(
          create: (context) => EventRepository(
            firestore: firebaseFirestore,
          ),
        ),
        RepositoryProvider<SearchRepository>(
          create: (context) => SearchRepository(
            livescoreRepository: context.read<LivescoreRepository>(),
          ),
        ),
        RepositoryProvider<LiveBetRepository>(
          create: (context) => LiveBetRepository(
            livescoreRepository: context.read<LivescoreRepository>(),
            firestore: firebaseFirestore,
          ),
        ),
        RepositoryProvider<DashRepository>(
          create: (context) => DashRepository(
            firestore: firebaseFirestore,
            storage: firebaseStorage,
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<OzareRepository>(),
            )..add(
                const AuthCheckRequested(),
              ),
          ),
          BlocProvider<SoccerBloc>(
            create: (context) => SoccerBloc(
              dashRepository: context.read<DashRepository>(),
              livescoreRepository: context.read<LivescoreRepository>(),
            ),
          ),
          BlocProvider<CricketBloc>(
            create: (context) => CricketBloc(
              dashRepository: context.read<DashRepository>(),
              livescoreRepository: context.read<LivescoreRepository>(),
            ),
          ),
          BlocProvider<BasketBloc>(
            create: (context) => BasketBloc(
              dashRepository: context.read<DashRepository>(),
              livescoreRepository: context.read<LivescoreRepository>(),
            ),
          ),
          BlocProvider<HomeCubit>(create: (context) => HomeCubit()),

          /// Profile Bloc
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              profileRepository: context.read<ProfileRepository>(),
              authRepository: context.read<OzareRepository>(),
            ),
          ),

          /// Event Bloc
          BlocProvider<EventBloc>(
            create: (context) => EventBloc(
              eventRepository: context.read<EventRepository>(),
              livescoreRepository: context.read<LivescoreRepository>(),
            ),
          ),

          // Search Bloc
          BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(
              repository: context.read<SearchRepository>(),
            ),
          ),

          // Live Bet Bloc
          BlocProvider<LiveBetBloc>(
            create: (context) => LiveBetBloc(
              liveBetRepository: context.read<LiveBetRepository>(),
              authRepository: context.read<OzareRepository>(),
            ),
          ),
          // Wallet Bloc
          BlocProvider<WalletBloc>(
            create: (context) => WalletBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ozare',
          theme: ThemeData(
            fontFamily: 'Poppins',
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: locale,
          initialRoute: Routes.splash,
          onGenerateRoute: Routes.onGenerateRouted,
        ),
      ),
    );
  }
}
