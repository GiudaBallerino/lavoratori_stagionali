part of 'home_cubit.dart';

enum HomeTab { list, dashboard }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.list,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}