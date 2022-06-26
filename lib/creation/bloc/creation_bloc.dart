import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:lavoratori_stagionali/utils/string_extension.dart';
import 'package:workers_api/workers_api.dart';
import 'package:workers_repository/workers_repository.dart';

part 'creation_state.dart';
part 'creation_event.dart';

class CreationBloc extends Bloc<CreationEvent, CreationState> {
  CreationBloc({
    required WorkersRepository workersRepository,
  })  : _workersRepository = workersRepository,
        super(
          const CreationState(),
        ) {
    on<EditSubscriptionRequested>(_onEditSubscriptionRequested);
    on<LanguagesSubscriptionRequested>(_onLanguagesSubscriptionRequested);
    on<LicensesSubscriptionRequested>(_onLicensesSubscriptionRequested);
    on<AreasSubscriptionRequested>(_onAreasSubscriptionRequested);
    on<FieldsSubscriptionRequested>(_onFieldsSubscriptionRequested);
    on<ResetAllState>(_onReset);
    on<WorkerSubmitted>(_onWorkerSubmitted);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<BirthdayChanged>(_onBirthdayChanged);
    on<BirthplaceChanged>(_onBirthplaceChanged);
    on<NationalityChanged>(_onNationalityChanged);
    on<AddressChanged>(_onAddressChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<EmailChanged>(_onEmailChanged);
    on<OwnCarChanged>(_onOwnCarChanged);
    on<LanguageAdded>(_onLanguageAdded);
    on<LanguageDeleted>(_onLanguageDeleted);
    on<LicenseAdded>(_onLicenseAdded);
    on<LicenseDeleted>(_onLicenseDeleted);
    on<AreaAdded>(_onAreaAdded);
    on<AreaDeleted>(_onAreaDeleted);
    on<PeriodAdded>(_onPeriodAdded);
    on<PeriodDeleted>(_onPeriodDeleted);
    on<FieldAdded>(_onTaskAdded);
    on<FieldDeleted>(_onTaskDeleted);
    on<ExperienceAdded>(_onExperienceAdded);
    on<ExperienceDeleted>(_onExperienceDeleted);
    on<EmergencyContactAdded>(_onEmergencyContactAdded);
    on<EmergencyContactDeleted>(_onEmergencyContactDeleted);
  }

  final WorkersRepository _workersRepository;

  Future<void> _onEditSubscriptionRequested(
    EditSubscriptionRequested event,
    Emitter<CreationState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: () => CreationStatus.success,
          firstname: () => event.worker.firstname,
          lastname: () => event.worker.lastname,
          birthday: ()=> DateFormat('dd/MM/yyyy').format(event.worker.birthday),
          birthplace: ()=>event.worker.birthplace,
          nationality: ()=>event.worker.nationality,
          address: ()=>event.worker.address,
          phone: ()=>event.worker.phone,
          email: ()=>event.worker.email,
          ownCar: ()=>event.worker.ownCar,
          languages: ()=>event.worker.languages,
          licenses: ()=>event.worker.licenses,
          areas: ()=>event.worker.areas,
          fields: ()=>event.worker.fields,
          periods: ()=>event.worker.periods,
          experiences: ()=>event.worker.experiences,
          emergencyContacts: ()=>event.worker.emergencyContacts,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onLanguagesSubscriptionRequested(
    LanguagesSubscriptionRequested event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    await emit.forEach<List<Worker>>(
      _workersRepository.getWorkers(),
      onData: (workers) {
        List<String> tmpLanguages = [];

        workers.forEach((w) {
          w.languages.forEach((l) {
            if (!tmpLanguages.contains(l.capitalize())) {
              tmpLanguages.add(l.capitalize());
            }
          });
        });

        return state.copyWith(
            status: () => CreationStatus.success,
            allLanguages: () => tmpLanguages);
      },
      onError: (_, __) => state.copyWith(
        status: () => CreationStatus.failure,
      ),
    );
  }

  Future<void> _onLicensesSubscriptionRequested(
    LicensesSubscriptionRequested event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    await emit.forEach<List<Worker>>(
      _workersRepository.getWorkers(),
      onData: (workers) {
        List<String> tmpLicenses = [];

        workers.forEach((w) {
          w.licenses.forEach((l) {
            if (!tmpLicenses.contains(l.toUpperCase())) {
              tmpLicenses.add(l.toUpperCase());
            }
          });
        });

        return state.copyWith(
            status: () => CreationStatus.success,
            allLicenses: () => tmpLicenses);
      },
      onError: (_, __) => state.copyWith(
        status: () => CreationStatus.failure,
      ),
    );
  }

  Future<void> _onAreasSubscriptionRequested(
    AreasSubscriptionRequested event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    await emit.forEach<List<Worker>>(
      _workersRepository.getWorkers(),
      onData: (workers) {
        List<String> tmpAreas = [];

        workers.forEach((w) {
          w.areas.forEach((a) {
            if (!tmpAreas.contains(a.toTitleCase())) {
              tmpAreas.add(a.toTitleCase());
            }
          });
        });

        return state.copyWith(
            status: () => CreationStatus.success, allAreas: () => tmpAreas);
      },
      onError: (_, __) => state.copyWith(
        status: () => CreationStatus.failure,
      ),
    );
  }

  Future<void> _onFieldsSubscriptionRequested(
    FieldsSubscriptionRequested event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    await emit.forEach<List<Worker>>(
      _workersRepository.getWorkers(),
      onData: (workers) {
        List<String> tmpFields = [];

        workers.forEach((w) {
          w.fields.forEach((f) {
            if (!tmpFields.contains(f.capitalize())) {
              tmpFields.add(f.capitalize());
            }
          });
        });

        return state.copyWith(
            status: () => CreationStatus.success, allFields: () => tmpFields);
      },
      onError: (_, __) => state.copyWith(
        status: () => CreationStatus.failure,
      ),
    );
  }

  Future<void> _onReset(
    ResetAllState event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
        status: () => CreationStatus.success,
        firstname: () => '',
        lastname: () => '',
        phone: () => '',
        email: () => '',
        birthday: () => '',
        birthplace: () => '',
        nationality: () => '',
        address: () => '',
        languages: () => [],
        licenses: () => [],
        areas: () => [],
        experiences: () => [],
        fields: () => [],
        periods: () => [],
        emergencyContacts: () => [],
      ));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onWorkerSubmitted(
    WorkerSubmitted event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      await _workersRepository.saveWorker(event.worker);
      emit(state.copyWith(status: () => CreationStatus.success));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onFirstNameChanged(
    FirstNameChanged event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success, firstname: () => event.text));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onLastNameChanged(
    LastNameChanged event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success, lastname: () => event.text));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onBirthdayChanged(
    BirthdayChanged event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success, birthday: () => event.text));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onBirthplaceChanged(
    BirthplaceChanged event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success, birthplace: () => event.text));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onNationalityChanged(
    NationalityChanged event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success, nationality: () => event.text));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onAddressChanged(
    AddressChanged event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success, address: () => event.text));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onPhoneChanged(
    PhoneChanged event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success, phone: () => event.text));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onEmailChanged(
    EmailChanged event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success, email: () => event.text));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onOwnCarChanged(
    OwnCarChanged event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success, ownCar: () => event.status));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onLanguageAdded(
    LanguageAdded event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success,
          languages: () => [
                ...state.languages,
                ...[event.language.capitalize()]
              ]));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onLanguageDeleted(
    LanguageDeleted event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      List<String> tmp = state.languages;
      tmp.remove(event.language);
      emit(state.copyWith(
          status: () => CreationStatus.success, languages: () => tmp));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onLicenseAdded(
    LicenseAdded event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success,
          licenses: () => [
                ...state.licenses,
                ...[event.license.toUpperCase()]
              ]));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onLicenseDeleted(
    LicenseDeleted event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      List<String> tmp = state.licenses;
      tmp.remove(event.license);
      emit(state.copyWith(
          status: () => CreationStatus.success, licenses: () => tmp));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onAreaAdded(
    AreaAdded event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success,
          areas: () => [
                ...state.areas,
                ...[event.area.toTitleCase()]
              ]));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onAreaDeleted(
    AreaDeleted event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      List<String> tmp = state.areas;
      tmp.remove(event.area);
      emit(state.copyWith(
          status: () => CreationStatus.success, areas: () => tmp));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onPeriodAdded(
    PeriodAdded event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      Period period = Period(start: event.start, end: event.end);
      emit(state.copyWith(
          status: () => CreationStatus.success,
          periods: () => [
                ...state.periods,
                ...[period]
              ]));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onPeriodDeleted(
    PeriodDeleted event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      List<Period> tmp = state.periods;
      tmp.remove(event.period);
      emit(state.copyWith(
          status: () => CreationStatus.success, periods: () => tmp));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onTaskAdded(
    FieldAdded event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success,
          fields: () => [
                ...state.fields,
                ...[event.field.capitalize()]
              ]));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onTaskDeleted(
    FieldDeleted event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      List<String> tmp = state.fields;
      tmp.remove(event.field);
      emit(state.copyWith(
          status: () => CreationStatus.success, fields: () => tmp));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onExperienceAdded(
    ExperienceAdded event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success,
          experiences: () => [
                ...state.experiences,
                ...[event.experience]
              ]));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onExperienceDeleted(
    ExperienceDeleted event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      List<Experience> tmp = state.experiences;
      tmp.remove(event.experience);
      emit(state.copyWith(
          status: () => CreationStatus.success, experiences: () => tmp));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onEmergencyContactAdded(
    EmergencyContactAdded event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      emit(state.copyWith(
          status: () => CreationStatus.success,
          emergencyContacts: () => [
                ...state.emergencyContacts,
                ...[event.emergencyContact]
              ]));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }

  Future<void> _onEmergencyContactDeleted(
    EmergencyContactDeleted event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    try {
      List<EmergencyContact> tmp = state.emergencyContacts;
      tmp.remove(event.emergencyContact);
      emit(state.copyWith(
          status: () => CreationStatus.success, emergencyContacts: () => tmp));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
  }
}
