import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:workers_api/workers_api.dart';
import 'package:workers_repository/workers_repository.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';


void bootstrap({required WorkersApi workersApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final workersRepository= WorkersRepository(workersApi: workersApi);

  runZonedGuarded(
        () async {
      await BlocOverrides.runZoned(
            () async => runApp(
          App(workersRepository: workersRepository,),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
        (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}