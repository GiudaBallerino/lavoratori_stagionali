import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filters/filters.dart';
import 'package:lavoratori_stagionali/utils/string_extension.dart';
import 'package:workers_api/workers_api.dart';
import 'package:workers_repository/workers_repository.dart';

part 'gallery_state.dart';
part 'gallery_event.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc({
    required WorkersRepository workersRepository,
  })  : _workersRepository = workersRepository,
        super(
          const GalleryState(),
        ) {
    on<WorkersSubscriptionRequested>(_onWorkersSubscriptionRequested);
    on<LanguagesSubscriptionRequested>(_onLanguagesSubscriptionRequested);
    on<LicensesSubscriptionRequested>(_onLicensesSubscriptionRequested);
    on<AreasSubscriptionRequested>(_onAreasSubscriptionRequested);
    on<FieldsSubscriptionRequested>(_onFieldsSubscriptionRequested);
    on<WorkerDeleted>(_onWorkerDeleted);
    on<WorkerUndoDeletionRequested>(_onUndoDeletionRequested);
    on<WorkerSelection>(_onWorkerSelected);
    on<OpenFilters>(_onOpenFilters);
    on<ChangeSearchMode>(_onSearchModeChange);
    on<AddLanguages>(_onAddLanguages);
    on<AddLicenses>(_onAddLicenses);
    on<AddAreas>(_onAddAreas);
    on<AddFields>(_onAddFields);
    on<AddPeriods>(_onAddPeriods);
    on<RemoveLanguages>(_onRemoveLanguages);
    on<RemoveLicenses>(_onRemoveLicenses);
    on<RemoveAreas>(_onRemoveAreas);
    on<RemoveFields>(_onRemoveFields);
    on<RemovePeriods>(_onRemovePeriods);
    on<OwnCarChange>(_onOwnCarChange);
  }

  final WorkersRepository _workersRepository;

  Future<void> _onWorkersSubscriptionRequested(
    WorkersSubscriptionRequested event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    await emit.forEach<List<Worker>>(
      _workersRepository.getWorkers(),
      onData: (workers) => state.copyWith(
          status: () => GalleryStatus.success, workers: () => workers),
      onError: (_, __) => state.copyWith(
        status: () => GalleryStatus.failure,
      ),
    );
  }

  Future<void> _onLanguagesSubscriptionRequested(
    LanguagesSubscriptionRequested event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    await emit.forEach<List<Worker>>(
      _workersRepository.getWorkers(),
      onData: (workers) {
        List<String> tmpLanguages = [];

        workers.forEach((w) {
          w.languages.forEach((l) {
            if (!tmpLanguages.contains(l.capitalize())) {
              tmpLanguages.add(l.capitalize());
            }
          });
        });

        return state.copyWith(
            status: () => GalleryStatus.success,
            allLanguages: () => tmpLanguages);
      },
      onError: (_, __) => state.copyWith(
        status: () => GalleryStatus.failure,
      ),
    );
  }

  Future<void> _onLicensesSubscriptionRequested(
    LicensesSubscriptionRequested event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    await emit.forEach<List<Worker>>(
      _workersRepository.getWorkers(),
      onData: (workers) {
        List<String> tmpLicenses = [];

        workers.forEach((w) {
          w.licenses.forEach((l) {
            if (!tmpLicenses.contains(l.toUpperCase())) {
              tmpLicenses.add(l.toUpperCase());
            }
          });
        });

        return state.copyWith(
            status: () => GalleryStatus.success,
            allLicenses: () => tmpLicenses);
      },
      onError: (_, __) => state.copyWith(
        status: () => GalleryStatus.failure,
      ),
    );
  }

  Future<void> _onAreasSubscriptionRequested(
    AreasSubscriptionRequested event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    await emit.forEach<List<Worker>>(
      _workersRepository.getWorkers(),
      onData: (workers) {
        List<String> tmpAreas = [];

        workers.forEach((w) {
          w.areas.forEach((a) {
            if (!tmpAreas.contains(a.toTitleCase())) {
              tmpAreas.add(a.toTitleCase());
            }
          });
        });

        return state.copyWith(
            status: () => GalleryStatus.success, allAreas: () => tmpAreas);
      },
      onError: (_, __) => state.copyWith(
        status: () => GalleryStatus.failure,
      ),
    );
  }

  Future<void> _onFieldsSubscriptionRequested(
    FieldsSubscriptionRequested event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    await emit.forEach<List<Worker>>(
      _workersRepository.getWorkers(),
      onData: (workers) {
        List<String> tmpFields = [];

        workers.forEach((w) {
          w.fields.forEach((f) {
            if (!tmpFields.contains(f.capitalize())) {
              tmpFields.add(f.capitalize());
            }
          });
        });

        return state.copyWith(
            status: () => GalleryStatus.success, allFields: () => tmpFields);
      },
      onError: (_, __) => state.copyWith(
        status: () => GalleryStatus.failure,
      ),
    );
  }

  Future<void> _onWorkerDeleted(
    WorkerDeleted event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(lastDeletedWorker: () => event.worker));
    await _workersRepository.deleteWorker(event.worker.id);
  }

  Future<void> _onUndoDeletionRequested(
    WorkerUndoDeletionRequested event,
    Emitter<GalleryState> emit,
  ) async {
    assert(
      state.lastDeletedWorker != null,
      'Last deleted img can not be null.',
    );

    final worker = state.lastDeletedWorker!;
    emit(state.copyWith(lastDeletedWorker: () => null));
    await _workersRepository.saveWorker(worker);
  }

  Future<void> _onWorkerSelected(
    WorkerSelection event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          selected: () => state.selected == event.selection ? null : event.selection,
          filtersIsOpen: ()=>state.selected == event.selection ? state.filtersIsOpen : false,
      ));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }

  Future<void> _onOpenFilters(
    OpenFilters event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          filtersIsOpen: () => !state.filtersIsOpen));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }


  Future<void> _onOwnCarChange(
    OwnCarChange event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          filters: () =>
              state.filters.copyWith(ownCar: !state.filters.ownCar)));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }

  Future<void> _onSearchModeChange(
      ChangeSearchMode event,
      Emitter<GalleryState> emit,
      ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          searchMode: () =>!state.searchMode));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }

  Future<void> _onAddLanguages(
    AddLanguages event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          filters: () => state.filters.copyWith(languages: [
                ...state.filters.languages,
                ...[event.language.capitalize()]
              ])));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }

  Future<void> _onAddLicenses(
    AddLicenses event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          filters: () => state.filters.copyWith(licenses: [
                ...state.filters.licenses,
                ...[event.license.toUpperCase()]
              ])));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }

  Future<void> _onAddAreas(
    AddAreas event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          filters: () => state.filters.copyWith(areas: [
                ...state.filters.areas,
                ...[event.area.toTitleCase()]
              ])));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }

  Future<void> _onAddFields(
    AddFields event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          filters: () => state.filters.copyWith(fields: [
                ...state.filters.fields,
                ...[event.field.capitalize()]
              ])));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }

  Future<void> _onAddPeriods(
    AddPeriods event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          filters: () => state.filters.copyWith(periods: [
                ...state.filters.periods,
                ...[event.period]
              ])));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }

  Future<void> _onRemoveLanguages(
    RemoveLanguages event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      List<String> tmp = state.filters.languages;
      tmp.remove(event.language);
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          filters: () => state.filters.copyWith(languages: tmp)));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }

  Future<void> _onRemoveLicenses(
    RemoveLicenses event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      List<String> tmp = state.filters.licenses;
      tmp.remove(event.license);
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          filters: () => state.filters.copyWith(licenses: tmp)));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }

  Future<void> _onRemoveAreas(
    RemoveAreas event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      List<String> tmp = state.filters.areas;
      tmp.remove(event.area);
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          filters: () => state.filters.copyWith(areas: tmp)));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }

  Future<void> _onRemoveFields(
    RemoveFields event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      List<String> tmp = state.filters.fields;
      tmp.remove(event.field);
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          filters: () => state.filters.copyWith(fields: tmp)));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }

  Future<void> _onRemovePeriods(
    RemovePeriods event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: () => GalleryStatus.loading));

    try {
      List<Period> tmp = state.filters.periods;
      tmp.remove(event.period);
      emit(state.copyWith(
          status: () => GalleryStatus.success,
          filters: () => state.filters.copyWith(periods: tmp)));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }
}
