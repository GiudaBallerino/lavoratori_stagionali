import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workers_api/workers_api.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void setTab(HomeTab tab) => emit(HomeState(tab: tab));
  void editWorker(Worker w)=> emit(HomeState(tab:HomeTab.creation,toEdit: w));
}