import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lavoratori_stagionali/creation/creation.dart';
import 'package:workers_api/workers_api.dart';
import 'package:workers_repository/workers_repository.dart';
import 'package:intl/intl.dart';

part 'creation_state.dart';
part 'creation_event.dart';

class CreationBloc extends Bloc<CreationEvent, CreationState> {
  CreationBloc({
    required WorkersRepository workersRepository,
  })  : _workersRepository = workersRepository,
        super(
          const CreationState(),
        ) {
    on<AllLicensesSubscriptionRequested>(_onAllLicensesSubscriptionRequested);
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

  Future<void> _onAllLicensesSubscriptionRequested(
    AllLicensesSubscriptionRequested event,
    Emitter<CreationState> emit,
  ) async {
    emit(state.copyWith(status: () => CreationStatus.loading));

    const List<String> _licensesOptions = <String>[
      'AM',
      'A1',
      'A2',
      'A',
      'B1',
      'B',
      'BE',
      'C1',
      'C1E',
      'C',
      'CE',
      'D1E',
      'D',
      'DE',
      'KA',
      'KB',
      'CQC Persone',
      'CQC Merci',
      'CFP'
    ];

    try {
      emit(state.copyWith(
        status: () => CreationStatus.success,
        allLicenses: () => _licensesOptions,
      ));
    } catch (e) {
      emit(state.copyWith(status: () => CreationStatus.failure));
    }
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
        birthday: () => null,
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
      DateTime date = DateFormat('dd/MM/yyyy').parse(event.text);
      emit(state.copyWith(
          status: () => CreationStatus.success, birthday: () => date));
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
                ...[event.language]
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
                ...[event.license]
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
                ...[event.area]
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
                ...[event.field]
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
