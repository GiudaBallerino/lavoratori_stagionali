import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavoratori_stagionali/app/app.dart';
import 'package:workers_repository/workers_repository.dart';

import '../bloc/app_bloc.dart';
import '../routes/routes.dart';

class App extends StatelessWidget {
  const App(
      {Key? key,
      required this.workersRepository,
      required this.authenticationRepository})
      : super(key: key);

  final WorkersRepository workersRepository;
  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: AppView(
          workersRepository: workersRepository,
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key, required this.workersRepository}) : super(key: key);
  final WorkersRepository workersRepository;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: (state, pages) =>
            onGenerateAppViewPages(state, pages, workersRepository),
      ),
    );
  }
}
