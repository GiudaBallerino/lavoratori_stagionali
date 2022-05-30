import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    on<WorkerDeleted>(_onWorkerDeleted);
    on<WorkerUndoDeletionRequested>(_onUndoDeletionRequested);
    on<WorkerSelection>(_onWorkerSelected);
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
          selected: () =>
              state.selected == event.selection ? null : event.selection));
    } catch (e) {
      emit(state.copyWith(status: () => GalleryStatus.failure));
    }
  }
}
