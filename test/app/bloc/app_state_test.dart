import 'package:employees_api/employees_api.dart';
import 'package:lavoratori_stagionali/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEmployee extends Mock implements Employee {}

void main() {
  group('AppState', () {
    group('unauthenticated', () {
      test('has correct status', () {
        final state = AppState.unauthenticated();
        expect(state.status, AppStatus.unauthenticated);
        expect(state.employee, Employee.empty);
      });
    });

    group('authenticated', () {
      test('has correct status', () {
        final employee = MockEmployee();
        final state = AppState.authenticated(employee);
        expect(state.status, AppStatus.authenticated);
        expect(state.employee, employee);
      });
    });
  });
}