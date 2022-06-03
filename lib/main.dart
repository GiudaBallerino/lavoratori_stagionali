import 'dart:io';
import 'package:authentication_repository/authentication_repository.dart';
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

  // -- Uncomment this for use local storage
  // final workersApi = StorageWorkersApi(
  //   plugin: await SharedPreferences.getInstance(),
  // );

  // Initialize mongoDb
  final  db = await Db.create('mongodb+srv://${Config.MONGO_USER}:${Config.MONGO_PASSWORD}@${Config.MONGO_HOST}/${Config.MONGO_DATABASE}?retryWrites=true&w=majority');
  await  db.open();

  //Get workers collection
  final workersCollection =  db.collection(Config.MONGO_COLLECTIONS[0]);

  //Initialize workers db api
  final workersApi = MongoDBWorkersApi(plugin: workersCollection);

  //Get employeers collection
  final employeersCollection =  db.collection(Config.MONGO_COLLECTIONS[1]);


  //Initialize authentication repository
  final authenticationRepository = AuthenticationRepository(authPlugin: await SharedPreferences.getInstance(), dbPlugin: employeersCollection,);


  bootstrap(workersApi: workersApi, authenticationRepository: authenticationRepository);
}
