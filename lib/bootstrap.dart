import 'dart:async';
import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:workers_api/workers_api.dart';
import 'package:workers_repository/workers_repository.dart';

import 'app/view/app.dart';
import 'app/app_bloc_observer.dart';

void bootstrap(
    {required WorkersApi workersApi,
    required AuthenticationRepository authenticationRepository}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final workersRepository = WorkersRepository(workersApi: workersApi);

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async {
          await authenticationRepository.employee.first;
          runApp(App(
            workersRepository: workersRepository,
            authenticationRepository: authenticationRepository,
          ));
        },
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
