import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/view/view.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  //todo add required repository

  @override
  Widget build(BuildContext context) {

    return MultiRepositoryProvider(
      providers: [
        //todo add required repository provider
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