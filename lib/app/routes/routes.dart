import 'package:flutter/widgets.dart';
import 'package:workers_repository/workers_repository.dart';

import '../../home/view/home_page.dart';
import '../../login/view/login_page.dart';
import '../bloc/app_bloc.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages, WorkersRepository workersRepository) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page(workersRepository)];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}