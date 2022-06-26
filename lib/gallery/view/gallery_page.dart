import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lavoratori_stagionali/creation/widgets/selection_list.dart';
import 'package:lavoratori_stagionali/creation/widgets/period_list.dart';
import 'package:lavoratori_stagionali/gallery/widgets/experience_card.dart';
import 'package:lavoratori_stagionali/gallery/widgets/filters_section.dart';
import 'package:lavoratori_stagionali/gallery/widgets/selection_list.dart';
import 'package:lavoratori_stagionali/gallery/widgets/search_bar.dart';
import 'package:lavoratori_stagionali/gallery/widgets/worker_card.dart';
import 'package:lavoratori_stagionali/gallery/widgets/worker_section.dart';
import 'package:workers_api/workers_api.dart';
import 'package:workers_repository/workers_repository.dart';

import '../../creation/bloc/creation_bloc.dart' show CreationBloc, EditSubscriptionRequested;
import '../../home/cubit/home_cubit.dart';
import '../bloc/gallery_bloc.dart';
import '../widgets/contact_card.dart';

class GalleryPage extends StatelessWidget {
  GalleryPage({Key? key}) : super(key: key);
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
                        content: Text(
                            "${deletedWorker.firstname} ${deletedWorker.lastname} eliminato con successo"),
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
            child: Row(
              children: [
                BlocBuilder<GalleryBloc, GalleryState>(
                  builder: (context, state) {
                    if (state.workers.isEmpty) {
                      if (state.status == GalleryStatus.loading) {
                        return const Center(
                            child: CupertinoActivityIndicator());
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
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            width: size.width * 0.5 - 48,
                            child: BlocBuilder<GalleryBloc, GalleryState>(
                                buildWhen: (previous, current) =>
                                    previous.filters.keywords !=
                                        current.filters.keywords ||
                                    previous.filtersIsOpen !=
                                        current.filtersIsOpen,
                                builder: (context, state) {
                                  return SearchBarWidget(
                                    backgroudColor:
                                        Theme.of(context).focusColor,
                                    onChange: (text) {
                                      context
                                          .read<GalleryBloc>()
                                          .add(KeywordsChange(text));
                                    },
                                    hintText: 'Cerca',
                                    suffix: IconButton(
                                      tooltip: 'Filtri',
                                      icon: Icon(
                                        state.filtersIsOpen
                                            ? Icons.filter_list_off
                                            : Icons.filter_list,
                                        color: Theme.of(context).hintColor,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<GalleryBloc>()
                                            .add(OpenFilters());
                                      },
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Expanded(
                          child: CupertinoScrollbar(
                            child: SizedBox(
                              width: size.width * 0.5 - 8,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  for (final worker in state.filteredWorkers)
                                    WorkerCard(
                                      worker: worker,
                                      selected: state.selected == worker,
                                      onDelete: () => context
                                          .read<GalleryBloc>()
                                          .add(WorkerDeleted(worker)),
                                      onSelected: () => context
                                          .read<GalleryBloc>()
                                          .add(WorkerSelection(worker)),
                                      onStartEdit: (){
                                        context.read<CreationBloc>().add(EditSubscriptionRequested(worker));
                                        context.read<HomeCubit>().editWorker(worker);
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                VerticalDivider(
                  thickness: 3,
                ),
                BlocBuilder<GalleryBloc, GalleryState>(
                  builder: (context, state) {
                    if (state.filtersIsOpen) {
                      return FilterSection(
                        width: size.width * 0.5 - 8,
                        filters: state.filters,
                        searchMode: state.searchMode,
                        allLanguages: state.allLanguages,
                        allLicenses: state.allLicenses,
                        allAreas: state.allAreas,
                        allFields: state.allFields,
                        changeMode: () =>
                            context.read<GalleryBloc>().add(ChangeSearchMode()),
                        addLanguages: (string) => context
                            .read<GalleryBloc>()
                            .add(AddLanguages(string)),
                        removeLanguages: (string) => context
                            .read<GalleryBloc>()
                            .add(RemoveLanguages(string)),
                        addLicenses: (string) => context
                            .read<GalleryBloc>()
                            .add(AddLicenses(string)),
                        removeLicenses: (string) => context
                            .read<GalleryBloc>()
                            .add(RemoveLicenses(string)),
                        addAreas: (string) =>
                            context.read<GalleryBloc>().add(AddAreas(string)),
                        removeAreas: (string) => context
                            .read<GalleryBloc>()
                            .add(RemoveAreas(string)),
                        addFields: (string) =>
                            context.read<GalleryBloc>().add(AddFields(string)),
                        removeFields: (string) => context
                            .read<GalleryBloc>()
                            .add(RemoveFields(string)),
                        changeOwnCar: (value) =>
                            context.read<GalleryBloc>().add(OwnCarChange()),
                        addPeriods: (date) =>
                            context.read<GalleryBloc>().add(AddPeriods(date)),
                        removePeriods: (period) => context
                            .read<GalleryBloc>()
                            .add(RemovePeriods(period)),
                      );
                    } else if (state.selected != null) {
                      return WorkerSection(
                        width: size.width * 0.5 - 8,
                        worker: state.selected!,
                      );
                    } else {
                      return Expanded(
                        child: Center(
                          child: Text(
                            "Nessun lavoratore selezionato",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
