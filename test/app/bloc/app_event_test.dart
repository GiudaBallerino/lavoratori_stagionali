import 'package:employees_api/employees_api.dart';
import 'package:lavoratori_stagionali/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEmployee extends Mock implements Employee {}

void main() {
  group('AppEvent', () {
    group('AppUserChanged', () {
      final employee = MockEmployee();
      test('supports value comparisons', () {
        expect(
          AppEmployeeChanged(employee),
          AppEmployeeChanged(employee),
        );
      });
    });

    group('AppLogoutRequested', () {
      test('supports value comparisons', () {
        expect(
          AppLogoutRequested(),
          AppLogoutRequested(),
        );
      });
    });
  });
}