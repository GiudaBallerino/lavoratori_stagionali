import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers_repository/workers_repository.dart';

import '../home/view/view.dart';


class App extends StatelessWidget {
  const App({Key? key, required this.workersRepository}) : super(key: key);

  final WorkersRepository workersRepository;

  @override
  Widget build(BuildContext context) {

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WorkersRepository>(create: (context) => workersRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}