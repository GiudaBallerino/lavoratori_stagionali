import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lavoratori_stagionali/gallery/gallery.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workers_repository/workers_repository.dart';

class MockWorkersRepository extends Mock implements WorkersRepository {}

class FakeWorker extends Fake implements Worker {}

void main() {
  final mockWorkers = [
    Worker(
      id: '0',
      firstname: 'Mario',
      lastname: 'Rossi',
      email: 'mariorossi@email.com',
      phone: '345234242',
      birthday: DateTime(1999, 1, 1),
      birthplace: 'Verona',
      nationality: 'Italiana',
      address: 'Via Roma 1, 37100, Verona',
      ownCar: true,
      languages: [],
      licenses: [],
      areas: [],
      fields: [],
      experiences: [],
      periods: [],
      emergencyContacts: [],
    ),
    Worker(
      id: '1',
      firstname: 'Mario',
      lastname: 'Rossi',
      email: 'mariorossi@email.com',
      phone: '345234242',
      birthday: DateTime(1999, 1, 1),
      birthplace: 'Verona',
      nationality: 'Italiana',
      address: 'Via Roma 1, 37100, Verona',
      ownCar: true,
      languages: [],
      licenses: [],
      areas: [],
      fields: [],
      experiences: [],
      periods: [],
      emergencyContacts: [],
    ),
    Worker(
      id: '2',
      firstname: 'Mario',
      lastname: 'Rossi',
      email: 'mariorossi@email.com',
      phone: '345234242',
      birthday: DateTime(1999, 1, 1),
      birthplace: 'Verona',
      nationality: 'Italiana',
      address: 'Via Roma 1, 37100, Verona',
      ownCar: true,
      languages: [],
      licenses: [],
      areas: [],
      fields: [],
      experiences: [],
      periods: [],
      emergencyContacts: [],
    ),
  ];

  group('WorkersOverviewBloc', () {
    late WorkersRepository workersRepository;

    setUpAll(() {
      registerFallbackValue(FakeWorker());
    });

    setUp(() {
      workersRepository = MockWorkersRepository();
      when(
        () => workersRepository.getWorkers(),
      ).thenAnswer((_) => Stream.value(mockWorkers));
      when(() => workersRepository.watch).thenAnswer((_) => Stream.empty());
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

    group('TodosOverviewSubscriptionRequested', () {
      blocTest<GalleryBloc, GalleryState>(
        'starts listening to repository getTodos stream',
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

    group('GalleryWorkerDeleted', () {
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

    // group('GalleryUndoDeletionRequested', () {
    //   blocTest<GalleryBloc, GalleryState>(
    //     'restores last deleted undo and clears lastDeletedUndo field',
    //     build: buildBloc,
    //     seed: () => GalleryState(lastDeletedWorker: mockWorkers.first),
    //     act: (bloc) => bloc.add(const WorkerUndoDeletionRequested()),
    //     expect: () => const [GalleryState()],
    //     verify: (_) {
    //       verify(() => workersRepository.saveWorker(mockWorkers.first)).called(1);
    //     },
    //   );
    // });

    // group('TodosOverviewFilterChanged', () {
    //   blocTest<GalleryBloc, GalleryState>(
    //     'emits state with updated filter',
    //     build: buildBloc,
    //     act: (bloc) => bloc.add(
    //       const ChangeSearchMode(),
    //     ),
    //     expect: () => const [
    //       GalleryState(searchMode: false),
    //       GalleryState(searchMode: true),
    //     ],
    //   );
    // });
  });
}
