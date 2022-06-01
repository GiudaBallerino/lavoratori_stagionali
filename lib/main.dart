import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mongodb_workers_api/mongodb_workers_api.dart'
    show Db, MongoDBWorkersApi;
import 'package:window_size/window_size.dart';
import 'package:local_storage_workers_api/local_storage_workers_api.dart';

import 'bootstrap.dart';
import 'config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Lavoratori Stagionali - Lista');
    setWindowMinSize(Size(1100, 700));
    // setWindowMaxSize(Size.infinite);
  }

  // final workersApi = StorageWorkersApi(
  //   plugin: await SharedPreferences.getInstance(),
  // );

  final db = await Db.create('mongodb+srv://${Config.MONGO_USER}:${Config.MONGO_PASSWORD}@${Config.MONGO_HOST}/${Config.MONGO_DATABASE}?retryWrites=true&w=majority');
  await db.open();
  final workersCollection = db.collection(Config.MONGO_COLLECTIONS[0]);

  final workersApi = MongoDBWorkersApi(plugin: workersCollection);

  bootstrap(workersApi: workersApi);
}
