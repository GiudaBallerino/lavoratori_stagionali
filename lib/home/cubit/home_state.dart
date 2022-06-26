part of 'home_cubit.dart';

enum HomeTab { gallery, creation }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.gallery,
    this.toEdit=null,
  });

  final HomeTab tab;
  final Worker? toEdit;
  @override
  List<Object> get props => [tab];
}