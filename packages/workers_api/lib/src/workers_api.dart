import 'package:workers_api/workers_api.dart';

abstract class WorkersApi {
  WorkersApi();

  Stream<List<Worker>> getWorkers();

  Future<void> saveWorker(Worker worker);

  Future<void> deleteWorker(String id);

}

class WorkerNotFoundException implements Exception {}