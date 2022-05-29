import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workers_api/workers_api.dart';
import 'package:workers_repository/workers_repository.dart';

part 'creation_state.dart';
part 'creation_event.dart';

class CreationBloc extends Bloc<CreationEvent, CreationState> {
  CreationBloc({
    required WorkersRepository workersRepository,
  })  : _workersRepository = workersRepository,
        super(const CreationState(),) {
    on<WorkerSubmitted>(_onWorkerSubmitted);
  }

  final WorkersRepository _workersRepository;

  Future<void> _onWorkerSubmitted(
      WorkerSubmitted event,
      Emitter<CreationState> emit,
      ) async {
    emit(state.copyWith(status: ()=> CreationStatus.loading));

    try {
      await _workersRepository.saveWorker(event.worker);
      emit(state.copyWith(status: ()=> CreationStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ()=> CreationStatus.failure));
    }
  }
}