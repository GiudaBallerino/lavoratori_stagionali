import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lavoratori_stagionali/gallery/widgets/experience_card.dart';
import 'package:lavoratori_stagionali/gallery/widgets/worker_card.dart';
import 'package:workers_repository/workers_repository.dart';

import '../bloc/gallery_bloc.dart';
import '../widgets/contact_card.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryBloc(
        workersRepository: context.read<WorkersRepository>(),
      )..add(
          const WorkersSubscriptionRequested(),
        ),
      child: GalleryView(),
    );
  }
}

class GalleryView extends StatelessWidget {
  GalleryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: MultiBlocListener(
            listeners: [
              BlocListener<GalleryBloc, GalleryState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == GalleryStatus.failure) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text("l10n.todosOverviewErrorSnackbarText"),
                        ),
                      );
                  }
                },
              ),
              BlocListener<GalleryBloc, GalleryState>(
                listenWhen: (previous, current) =>
                    previous.lastDeletedWorker != current.lastDeletedWorker &&
                    current.lastDeletedWorker != null,
                listener: (context, state) {
                  final deletedWorker = state.lastDeletedWorker!;
                  final messenger = ScaffoldMessenger.of(context);
                  messenger
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text("Eliminazione avvenuta con successo"),
                        action: SnackBarAction(
                          label: "Annulla",
                          onPressed: () {
                            messenger.hideCurrentSnackBar();
                            context
                                .read<GalleryBloc>()
                                .add(const WorkerUndoDeletionRequested());
                          },
                        ),
                      ),
                    );
                },
              ),
            ],
            child: BlocBuilder<GalleryBloc, GalleryState>(
              builder: (context, state) {
                if (state.workers.isEmpty) {
                  if (state.status == GalleryStatus.loading) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (state.status != GalleryStatus.success) {
                    return const SizedBox();
                  } else {
                    return Center(
                      child: Text(
                        "Nessun lavoratore trovato",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  }
                }
                return Row(
                  children: [
                    CupertinoScrollbar(
                      child: SizedBox(
                        width: size.width * 0.5 - 8,
                        child: ListView(
                          children: [
                            for (final worker in state.workers)
                              WorkerCard(
                                worker: worker,
                                selected: state.selected == worker,
                                onDelete: () => context
                                    .read<GalleryBloc>()
                                    .add(WorkerDeleted(worker)),
                                onSelected: () => context
                                    .read<GalleryBloc>()
                                    .add(WorkerSelection(worker)),
                              ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 3,
                    ),
                    if (state.selected != null)
                      CupertinoScrollbar(
                        child: SizedBox(
                          width: size.width * 0.5 - 8,
                          child: Wrap(
                            children: [
                              SizedBox(
                                width: size.width * 0.5 - 8,
                                child: Text(
                                  '${state.selected!.firstname} ${state.selected!.lastname}',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.25 - 8,
                                child: Text(
                                  'e-mail: ${state.selected!.email}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.25 - 8,
                                child: Text(
                                  'Nato il: ${DateFormat('dd/MM/yyyy').format(state.selected!.birthday)}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.25 - 8,
                                child: Text(
                                  'telefono: ${state.selected!.phone}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.25 - 8,
                                child: Text(
                                  'A: ${state.selected!.birthplace}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.25 - 8,
                                child: Text(
                                  'indirizzo: ${state.selected!.address}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.25 - 8,
                                child: Text(
                                  'Nazionalità: ${state.selected!.nationality}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                width: size.width * 0.25 - 8,
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.25 - 8,
                                      child: Text(
                                        'Lingue parlate:',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    for (final lang
                                        in state.selected!.languages)
                                      Chip(
                                        label: Text(lang),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.25 - 8,
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.25 - 8,
                                      child: Text(
                                        'Patenti:',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    for (final lic in state.selected!.licenses)
                                      Chip(
                                        label: Text(lic),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.25 - 8,
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.25 - 8,
                                      child: Text(
                                        'Zone:',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    for (final area in state.selected!.areas)
                                      Chip(
                                        label: Text(area),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.25 - 8,
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.25 - 8,
                                      child: Text(
                                        'Specializzazioni:',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    for (final field in state.selected!.fields)
                                      Chip(
                                        label: Text(field),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.25 - 8,
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.25 - 8,
                                      child: Text(
                                        'Periodi:',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    for (final period
                                        in state.selected!.periods)
                                      Chip(
                                        label: Text(
                                            '${DateFormat('dd/MM').format(period.start)} - ${DateFormat('dd/MM').format(period.end)}'),
                                      ),
                                  ],
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                width: size.width * 0.5 - 8,
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.5 - 8,
                                      child: Text(
                                        'Esperienze:',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    for (final experience
                                        in state.selected!.experiences)
                                      ExperienceCard(
                                          width: size.width * 0.5 - 8,
                                          experience: experience),
                                  ],
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                width: size.width * 0.5 - 8,
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.5 - 8,
                                      child: Text(
                                        'Contatti di emergenza:',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    for (final contact
                                        in state.selected!.emergencyContacts)
                                      ContactCard(
                                          width: size.width * 0.5 - 8,
                                          contact: contact),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
