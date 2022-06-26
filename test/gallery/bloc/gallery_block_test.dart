import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lavoratori_stagionali/gallery/bloc/gallery_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:workers_repository/workers_repository.dart';

class MockWorkersRepository extends Mock implements WorkersRepository {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class FakeWorker extends Fake implements Worker {}

void main() {
  final mockWorkers = [
    Worker(
        id: '1',
        firstname: 'name 1',
        lastname: 'lastname 1',
        email: 'email 1',
        phone: 'phone 1',
        birthday: DateTime(2001, 01, 01),
        birthplace: 'birthplace 1',
        nationality: 'nationality 1',
        address: 'address 1',
        ownCar: true,
        languages: ['it'],
        licenses: ['A'],
        areas: [],
        fields: [],
        experiences: [],
        periods: [],
        emergencyContacts: []
    ),
    Worker(
        id: '2',
        firstname: 'name 2',
        lastname: 'lastname 2',
        email: 'email 2',
        phone: 'phone 2',
        birthday: DateTime(2002, 02, 02),
        birthplace: 'birthplace 2',
        nationality: 'nationality 2',
        address: 'address 2',
        ownCar: false,
        languages: ['en'],
        licenses: ['B'],
        areas: [],
        fields: [],
        experiences: [],
        periods: [],
        emergencyContacts: []
    ),
  ];

  group('GalleryBloc', () {
    late MockWorkersRepository workersRepository;
    late MockAuthenticationRepository authenticationRepository;

    setUpAll(() {
      registerFallbackValue(FakeWorker());
    });

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();

      workersRepository = MockWorkersRepository();
      when(
            () => workersRepository.getWorkers(),
      ).thenAnswer((_) => const Stream.empty());
    });

    GalleryBloc buildBloc() {
      return GalleryBloc(workersRepository: workersRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(const GalleryState()),
        );
      });
    });

    group('GallerySubscriptionRequested', () {
      blocTest<GalleryBloc, GalleryState>(
        'starts listening to repository getWorkers stream',
        build: buildBloc,
        act: (bloc) => bloc.add(const WorkersSubscriptionRequested()),
        verify: (_) {
          verify(() => workersRepository.getWorkers()).called(1);
        },
      );

      blocTest<GalleryBloc, GalleryState>(
        'emits state with updated status and workers '
        'when repository getWorkers stream emits new workers',
        build: buildBloc,
        act: (bloc) => bloc.add(const WorkersSubscriptionRequested()),
        expect: () => [
          const GalleryState(
            status: GalleryStatus.loading,
          ),
          GalleryState(
            status: GalleryStatus.success,
            workers: mockWorkers,
          ),
        ],
      );

      blocTest<GalleryBloc, GalleryState>(
        'emits state with failure status '
        'when repository getWorkers stream emits error',
        setUp: () {
          when(
            () => workersRepository.getWorkers(),
          ).thenAnswer((_) => Stream.error(Exception('oops')));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const WorkersSubscriptionRequested()),
        expect: () => [
          const GalleryState(status: GalleryStatus.loading),
          const GalleryState(status: GalleryStatus.failure),
        ],
      );
    });

    /*group('GalleryWorkerCompletionToggled', () {
      blocTest<GalleryBloc, GalleryState>(
        'saves worker with isCompleted set to event isCompleted flag',
        build: buildBloc,
        seed: () => GalleryState(workers: mockWorkers),
        act: (bloc) => bloc.add(
          GalleryWorkerCompletionToggled(
            todo: mockWorkers.first,
            isCompleted: true,
          ),
        ),
        verify: (_) {
          verify(
            () => workersRepository.saveWorker(
              mockWorkers.first.copyWith(isCompleted: true),
            ),
          ).called(1);
        },
      );
    });*/

    group('GalleryBlocWorkerDeleted', () {
      blocTest<GalleryBloc, GalleryState>(
        'deletes worker using repository',
        setUp: () {
          when(
            () => workersRepository.deleteWorker(any()),
          ).thenAnswer((_) async {});
        },
        build: buildBloc,
        seed: () => GalleryState(workers: mockWorkers),
        act: (bloc) => bloc.add(WorkerDeleted(mockWorkers.first)),
        verify: (_) {
          verify(
            () => workersRepository.deleteWorker(mockWorkers.first.id),
          ).called(1);
        },
      );
    });

    group('TodosOverviewUndoDeletionRequested', () {
      blocTest<GalleryBloc, GalleryState>(
        'restores last deleted undo and clears lastDeletedUndo field',
        build: buildBloc,
        seed: () => GalleryState(lastDeletedWorker: mockWorkers.first),
        act: (bloc) => bloc.add(const WorkerUndoDeletionRequested()),
        expect: () => const [GalleryState()],
        verify: (_) {
          verify(() => workersRepository.saveWorker(mockWorkers.first)).called(1);
        },
      );
    });

    /*group('TodosOverviewFilterChanged', () {
      blocTest<TodosOverviewBloc, TodosOverviewState>(
        'emits state with updated filter',
        build: buildBloc,
        act: (bloc) => bloc.add(
          const TodosOverviewFilterChanged(TodosViewFilter.completedOnly),
        ),
        expect: () => const [
          TodosOverviewState(filter: TodosViewFilter.completedOnly),
        ],
      );
    });*/

  });
}
