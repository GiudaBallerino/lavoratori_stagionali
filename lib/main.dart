import 'package:flutter/material.dart';
import 'package:storage_workers_api/storage_workers_api.dart';

import 'bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final workersApi = StorageWorkersApi(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(workersApi: workersApi);
}