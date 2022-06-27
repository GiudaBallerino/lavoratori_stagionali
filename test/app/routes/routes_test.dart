import 'package:flutter/material.dart';
import 'package:lavoratori_stagionali/app/app.dart';
import 'package:lavoratori_stagionali/config.dart';
import 'package:lavoratori_stagionali/home/view/home_page.dart';
import 'package:lavoratori_stagionali/login/view/login_page.dart';
import 'package:mongodb_workers_api/mongodb_workers_api.dart';
import 'package:workers_repository/workers_repository.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('onGenerateAppViewPages', () {
    test('returns [HomePage] when authenticated', () async {
      // Initialize mongoDb
      final  db = await Db.create('mongodb+srv://${Config.MONGO_USER}:${Config.MONGO_PASSWORD}@${Config.MONGO_HOST}/${Config.MONGO_DATABASE}?retryWrites=true&w=majority');
      await  db.open();

      //Get workers collection
      final workersCollection =  db.collection(Config.MONGO_COLLECTIONS[0]);

      //Initialize workers db api
      final workersApi = MongoDBWorkersApi(plugin: workersCollection);

      //Initialize workers repo
      final workersRepository = WorkersRepository(workersApi: workersApi);

      expect(
        onGenerateAppViewPages(AppStatus.authenticated, [], workersRepository),
        [isA<MaterialPage>().having((p) => p.child, 'child', isA<HomePage>())],
      );
    });

    test('returns [LoginPage] when unauthenticated', () async {
      // Initialize mongoDb
      final  db = await Db.create('mongodb+srv://${Config.MONGO_USER}:${Config.MONGO_PASSWORD}@${Config.MONGO_HOST}/${Config.MONGO_DATABASE}?retryWrites=true&w=majority');
      await  db.open();

      //Get workers collection
      final workersCollection =  db.collection(Config.MONGO_COLLECTIONS[0]);

      //Initialize workers db api
      final workersApi = MongoDBWorkersApi(plugin: workersCollection);

      //Initialize workers repo
      final workersRepository = WorkersRepository(workersApi: workersApi);

      expect(
        onGenerateAppViewPages(AppStatus.unauthenticated, [], workersRepository),
        [isA<MaterialPage>().having((p) => p.child, 'child', isA<LoginPage>())],
      );
    });
  });
}