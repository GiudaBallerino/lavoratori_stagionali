part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class AppEmployeeChanged extends AppEvent {
  const AppEmployeeChanged(this.employee);

  final Employee? employee;

  @override
  List<Object?> get props => [employee];
}