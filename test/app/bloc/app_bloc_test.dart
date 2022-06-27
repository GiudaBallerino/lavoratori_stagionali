import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:employees_api/employees_api.dart';
import 'package:lavoratori_stagionali/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockEmployee extends Mock implements Employee {}

void main() {
  group('AppBloc', () {
    final employee = MockEmployee();
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      when(() => authenticationRepository.employee).thenAnswer(
            (_) => Stream.empty(),
      );
      when(
            () => authenticationRepository.currentEmployee,
      ).thenReturn(Employee.empty);
    });

    test('initial state is unauthenticated when employee is empty', () {
      expect(
        AppBloc(authenticationRepository: authenticationRepository).state,
        AppState.unauthenticated(),
      );
    });

    group('UserChanged', () {
      blocTest<AppBloc, AppState>(
        'emits authenticated when employee is not empty',
        setUp: () {
          when(() => employee.isNotEmpty).thenReturn(true);
          when(() => authenticationRepository.employee).thenAnswer(
                (_) => Stream.value(employee),
          );
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
        ),
        seed: AppState.unauthenticated,
        expect: () => [AppState.authenticated(employee)],
      );

      blocTest<AppBloc, AppState>(
        'emits unauthenticated when employee is empty',
        setUp: () {
          when(() => authenticationRepository.employee).thenAnswer(
                (_) => Stream.value(Employee.empty),
          );
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
        ),
        expect: () => [AppState.unauthenticated()],
      );
    });

    group('LogoutRequested', () {
      blocTest<AppBloc, AppState>(
        'invokes logOut',
        setUp: () {
          when(
                () => authenticationRepository.logOut(),
          ).thenAnswer((_) async {});
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(AppLogoutRequested()),
        verify: (_) {
          verify(() => authenticationRepository.logOut()).called(1);
        },
      );
    });
  });
}