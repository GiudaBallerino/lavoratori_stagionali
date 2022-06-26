import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:workers_repository/workers_repository.dart';

import 'package:lavoratori_stagionali/app/app.dart';


class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}
class MockWorkersRepository extends Mock implements WorkersRepository {}

void main() {
  late MockWorkersRepository workersRepository;
  late MockAuthenticationRepository authenticationRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();

    workersRepository = MockWorkersRepository();
    when(
        () => workersRepository.getWorkers(),
    ).thenAnswer((_) => const Stream.empty());
  });

  group('App', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(workersRepository: workersRepository,
            authenticationRepository: authenticationRepository),
      );
      expect(find.byType(AppView), findsOneWidget);
    });
  });

}
