import 'package:workers_api/workers_api.dart';

class WorkersRepository {
  const WorkersRepository({
    required WorkersApi workersApi,
  }) : _workersApi = workersApi;

  final WorkersApi _workersApi;

  Stream<List<Worker>> get watch => _workersApi.watch;

  Stream<List<Worker>> getWorkers() => _workersApi.getWorkers();

  Future<void> saveWorker(Worker worker) => _workersApi.saveWorker(worker);

  Future<void> deleteWorker(String id) => _workersApi.deleteWorker(id);
}