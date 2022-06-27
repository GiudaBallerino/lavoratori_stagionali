import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:employees_api/employees_api.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentEmployee.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentEmployee)
              : const AppState.unauthenticated(),
        ) {
    on<AppEmployeeChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _employeeSubscription = _authenticationRepository.employee.listen(
      (employee) => add(AppEmployeeChanged(employee)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<Employee?> _employeeSubscription;

  void _onUserChanged(AppEmployeeChanged event, Emitter<AppState> emit) {
    emit(
      event.employee.isNotEmpty
          ? AppState.authenticated(event.employee)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _employeeSubscription.cancel();
    return super.close();
  }
}
