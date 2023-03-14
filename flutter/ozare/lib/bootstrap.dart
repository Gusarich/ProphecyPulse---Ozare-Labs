// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:livescore_api/livescore_api.dart';
import 'package:local_api/local_api.dart';
import 'package:ozare/app/app.dart';
import 'package:ozare/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  final livescoreClient = LivescoreApiClient();
  final sharedPreferences = await SharedPreferences.getInstance();
  final localLivescoreClient =
      LivescoreApi(sharedPreferences: sharedPreferences);

  await runZonedGuarded(
    () async => runApp(
      App(
        firebaseFirestore: firestore,
        livescoreClientApi: livescoreClient,
        firebaseStorage: firebaseStorage,
        sharedPreferences: sharedPreferences,
        localLivescoreClient: localLivescoreClient,
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
