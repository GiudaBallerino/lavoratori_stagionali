import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';


void bootstrap() {//todo add required api as parameter
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  //todo initialize required repository

  runZonedGuarded(
        () async {
      await BlocOverrides.runZoned(
            () async => runApp(
          App(),//todo add required repository
        ),
        blocObserver: AppBlocObserver(),
      );
    },
        (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}