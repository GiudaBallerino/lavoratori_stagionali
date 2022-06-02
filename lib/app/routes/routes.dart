import 'package:flutter/widgets.dart';
import 'package:lavoratori_stagionali/home/home.dart';

import '../../login/view/login_page.dart';
import '../bloc/app_bloc.dart';
//import 'package:lavoratori_stagionali/login/login.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}