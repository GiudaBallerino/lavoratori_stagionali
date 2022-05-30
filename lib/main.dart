import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:storage_workers_api/storage_workers_api.dart';

import 'bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Lavoratori Stagionali');
    setWindowMinSize(const Size(1100, 700));
    // setWindowMaxSize(Size.infinite);
  }

  final workersApi = StorageWorkersApi(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(workersApi: workersApi);
}