part of 'app_bloc.dart';


enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.employee = null,
  });

  const AppState.authenticated(Employee employee)
      : this._(status: AppStatus.authenticated, employee: employee);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final Employee? employee;

  @override
  List<Object?> get props => [status, employee];
}