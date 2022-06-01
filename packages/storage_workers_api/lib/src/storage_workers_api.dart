import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workers_api/workers_api.dart';

class StorageWorkersApi extends WorkersApi {
  StorageWorkersApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _workerStreamController = BehaviorSubject<List<Worker>>.seeded(const []);

  @visibleForTesting
  static const kWorkersCollectionKey = '__workers_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final workersJson = _getValue(kWorkersCollectionKey);
    if (workersJson != null) {
      final workers = List<Map>.from(json.decode(workersJson) as List)
          .map((jsonMap) => Worker.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _workerStreamController.add(workers);
    } else {
      _workerStreamController.add(const []);
    }
  }

  @override
  Stream<List<Worker>> getWorkers() => _workerStreamController.asBroadcastStream();

  @override
  Future<void> saveWorker(Worker worker) {
    final workers = [..._workerStreamController.value];
    final workerIndex = workers.indexWhere((w) => w.getId == worker.getId);
    if (workerIndex >= 0) {
      workers[workerIndex] = worker;
    } else {
      workers.add(worker);
    }

    _workerStreamController.add(workers);
    return _setValue(kWorkersCollectionKey, json.encode(workers));
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
      return _setValue(kWorkersCollectionKey, json.encode(workers));
    }
  }
}