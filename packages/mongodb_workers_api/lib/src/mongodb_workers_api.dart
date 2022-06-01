import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rxdart/subjects.dart';
import 'package:workers_api/workers_api.dart';

class MongoDBWorkersApi extends WorkersApi {
  MongoDBWorkersApi({
    required DbCollection plugin,
  }) : _plugin = plugin {
    _init();
  }

  final DbCollection _plugin;

  final _workerStreamController =
      BehaviorSubject<List<Worker>>.seeded(const []);

  @visibleForTesting
  static const kWorkersCollectionKey = 'workers';

  Future<List<Map<String, dynamic>>> _getValue() async =>
      await _plugin.find().toList();
  Future<void> _updateValue(String id, Map<String, dynamic> value) async =>
      await _plugin.updateOne(where.eq('id', id), value);
  Future<void> _setValue(Map<String, dynamic> value) async =>
      await _plugin.insertOne(value);
  Future<void> _deleteValue(String id) async=>await _plugin.deleteOne(where.eq('id', id));

  Future<void> _init() async {
    final workersJson = await _getValue();
    print(workersJson);
    if (workersJson != null) {
      List<Worker> workers = List.generate(
          workersJson.length, (index) => Worker.fromJson(workersJson[index]));
      _workerStreamController.add(workers);
    } else {
      _workerStreamController.add(const []);
    }
  }

  @override
  Stream<List<Worker>> getWorkers() =>
      _workerStreamController.asBroadcastStream();

  @override
  Future<void> saveWorker(Worker worker) async{
    final workers = [..._workerStreamController.value];
    final workerIndex = workers.indexWhere((w) => w.getId == worker.getId);
    if (workerIndex >= 0) {
      workers[workerIndex] = worker;
      _workerStreamController.add(workers);
      return await _updateValue(workers[workerIndex].id, worker.toJson());
    } else {
      workers.add(worker);
      _workerStreamController.add(workers);
      return _setValue(worker.toJson());
    }
  }

  @override
  Future<void> deleteWorker(String id) async {
    final workers = [..._workerStreamController.value];
    final workerIndex = workers.indexWhere((w) => w.getId == id);
    if (workerIndex == -1) {
      throw WorkerNotFoundException();
    } else {
      workers.removeAt(workerIndex);
      _workerStreamController.add(workers);
      return await _deleteValue(id);
    }
  }
}
