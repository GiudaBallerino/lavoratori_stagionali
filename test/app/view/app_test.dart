import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:employees_api/employees_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lavoratori_stagionali/app/app.dart';
import 'package:lavoratori_stagionali/home/view/home_page.dart';
import 'package:lavoratori_stagionali/login/view/login_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workers_repository/workers_repository.dart';

class MockEmployee extends Mock implements Employee {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockWorkersRepository extends Mock
    implements WorkersRepository{}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}


void main(){
  group('App', () {
    late AuthenticationRepository authenticationRepository;
    late WorkersRepository workersRepository;
    late Employee employee;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      workersRepository = MockWorkersRepository();
      employee = MockEmployee();
      when(() => authenticationRepository.employee).thenAnswer(
            (_) => const Stream.empty(),
      );
      when(() => authenticationRepository.currentEmployee).thenReturn(employee);
      when(() => employee.isNotEmpty).thenReturn(true);
      when(() => employee.isEmpty).thenReturn(false);
      when(() => employee.email).thenReturn('test@gmail.com');
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(authenticationRepository: authenticationRepository, workersRepository: workersRepository,),
      );
      await tester.pump();
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    late AuthenticationRepository authenticationRepository;
    late WorkersRepository workersRepository;
    late AppBloc appBloc;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      workersRepository = MockWorkersRepository();
      appBloc = MockAppBloc();
    });

    testWidgets('navigates to LoginPage when unauthenticated', (tester) async {
      when(() => appBloc.state).thenReturn(const AppState.unauthenticated());
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: MaterialApp(
            home: BlocProvider.value(value: appBloc, child:  AppView(workersRepository: workersRepository,)),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('navigates to HomePage when authenticated', (tester) async {
      final employee = MockEmployee();
      when(() => employee.email).thenReturn('test@gmail.com');
      when(() => appBloc.state).thenReturn(AppState.authenticated(employee));
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: MaterialApp(
            home: BlocProvider.value(value: appBloc, child: AppView(workersRepository: workersRepository,)),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}