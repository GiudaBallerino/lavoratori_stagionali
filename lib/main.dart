import 'package:flutter/material.dart';

import 'bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //todo initialize required api
  // final imgApi = LocalStorageImgsApi(
  //   plugin: await SharedPreferences.getInstance(),
  // );
  //
  // final tagApi = LocalStorageTagsApi(
  //   plugin: await SharedPreferences.getInstance(),
  // );

  bootstrap();//todo add required parameter
}