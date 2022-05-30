// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_size/window_size.dart';

//Project imports
import '../../creation/view/creation_page.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
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
        children: const [
          //todo add destination page
          CreationPage(),
          CreationPage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.list,
              icon: const Icon(Icons.collections),
              title: "Lavoratori Stagionali - Lista",
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.dashboard,
              icon: const Icon(Icons.settings),
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
