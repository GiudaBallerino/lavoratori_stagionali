// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_size/window_size.dart';
import 'package:workers_repository/workers_repository.dart';

//Project imports
import '../../app/bloc/app_bloc.dart';
import '../../creation/bloc/creation_bloc.dart' as c;
import '../../creation/view/creation_page.dart';
import '../../gallery/bloc/gallery_bloc.dart';
import '../../gallery/view/gallery_page.dart';
import '../cubit/home_cubit.dart';

enum Menu {
  Logout,
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.workersRepository}) : super(key: key);
  final WorkersRepository workersRepository;

  static Page page(WorkersRepository workersRepository) => MaterialPage<void>(
          child: HomePage(
        workersRepository: workersRepository,
      ));
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: RepositoryProvider<WorkersRepository>(
        create: (context) => workersRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => GalleryBloc(workersRepository: workersRepository)        ..add(
                const WorkersSubscriptionRequested(),
              )
                ..add(
                  const LanguagesSubscriptionRequested(),
                )
                ..add(
                  const LicensesSubscriptionRequested(),
                )
                ..add(
                  const AreasSubscriptionRequested(),
                )
                ..add(
                  const FieldsSubscriptionRequested(),
                ),
            ),
            BlocProvider(
              create: (_) =>
                  c.CreationBloc(workersRepository: workersRepository)
                    ..add(
                      const c.LanguagesSubscriptionRequested(),
                    )
                    ..add(
                      const c.LicensesSubscriptionRequested(),
                    )
                    ..add(
                      const c.AreasSubscriptionRequested(),
                    )
                    ..add(
                      const c.FieldsSubscriptionRequested(),
                    ),
            ),
          ],
          child: HomeView(),
        ),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: [
          GalleryPage(),
          CreationPage(toEdit: context.select((HomeCubit cubit) => cubit.state.toEdit),),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Logout",
        backgroundColor: Colors.white,
        child: Icon(
          Icons.logout,
          color: Colors.black,
        ),
        onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniStartDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.gallery,
              icon: const Icon(Icons.people),
              title: "Lavoratori Stagionali - Lista",
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.creation,
              icon: const Icon(Icons.add),
              title: "Lavoratori Stagionali - Creazione",
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<HomeCubit>().setTab(value);
        setWindowTitle(title);
      },
      iconSize: 32,
      color:
          groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}
