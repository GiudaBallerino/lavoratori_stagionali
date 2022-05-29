import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers_repository/workers_repository.dart';

import '../bloc/creation_bloc.dart';

class CreationPage extends StatelessWidget {
  const CreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreationBloc(
        workersRepository: context.read<WorkersRepository>(),
      ),
      child: const CreationView(),
    );
  }
}

class CreationView extends StatelessWidget {
  const CreationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<CreationBloc, CreationState>(
        listenWhen: (previous, current) =>
        previous.status != current.status,
        listener: (context, state) {
          if (state.status == CreationStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("Creazione fallita"),
                ),
              );
          }
          else if (state.status == CreationStatus.success) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("Creazione avvenuta con successo"),
                ),
              );
          }
        },
        child: BlocBuilder<CreationBloc, CreationState>(
          builder: (context, state){
            final _formKey = GlobalKey<FormState>();
            TextEditingController _firstName=TextEditingController();
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Text('Aggiungi un nuovo lavoratore', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
// -- FIRST NAME
                          TextFormField(
                            controller: _firstName,

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
