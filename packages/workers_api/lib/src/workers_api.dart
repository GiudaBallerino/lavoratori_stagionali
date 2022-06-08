import 'package:workers_api/workers_api.dart';

abstract class WorkersApi{
  WorkersApi();

  Stream<List<Worker>> getWorkers();

  Future<void> saveWorker(Worker worker);

  Future<void> deleteWorker(String id);

  Stream get watch;

  Future<void> init();
}

class WorkerNotFoundException implements Exception {}