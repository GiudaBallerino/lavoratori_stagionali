part of 'creation_bloc.dart';

enum CreationStatus { initial, loading, success, failure }

extension CreationStatusX on CreationStatus {
  bool get isLoadingOrSuccess => [
        CreationStatus.loading,
        CreationStatus.success,
      ].contains(this);
}

class CreationState extends Equatable {
  const CreationState({
    this.status = CreationStatus.initial,
    this.allLicenses = const [],
    this.allLanguages = const [],
    this.allAreas = const [],
    this.allFields = const [],
    this.firstname,
    this.lastname,
    this.birthday,
    this.birthplace,
    this.nationality,
    this.address,
    this.phone,
    this.email,
    this.ownCar = false,
    this.languages = const [],
    this.licenses = const [],
    this.areas = const [],
    this.fields = const [],
    this.periods = const [],
    this.experiences = const [],
    this.emergencyContacts = const [],
  });

  //funzionamento
  final CreationStatus status;
  final List<String> allLanguages;
  final List<String> allLicenses;
  final List<String> allAreas;
  final List<String> allFields;

  //inserimento
  final String? firstname;
  final String? lastname;
  final String? birthday;
  final String? birthplace;
  final String? nationality;
  final String? address;
  final String? phone;
  final String? email;
  final bool ownCar;
  final List<String> languages;
  final List<String> licenses;
  final List<String> areas;
  final List<String> fields;
  final List<Period> periods;
  final List<Experience> experiences;
  final List<EmergencyContact> emergencyContacts;

  CreationState copyWith({
    CreationStatus Function()? status,
    List<String> Function()? allLanguages,
    List<String> Function()? allLicenses,
    List<String> Function()? allAreas,
    List<String> Function()? allFields,
    String? Function()? firstname,
    String? Function()? lastname,
    String? Function()? birthday,
    String? Function()? birthplace,
    String? Function()? nationality,
    String? Function()? address,
    String? Function()? phone,
    String? Function()? email,
    bool Function()? ownCar,
    List<String> Function()? languages,
    List<String> Function()? licenses,
    List<String> Function()? areas,
    List<String> Function()? fields,
    List<Period> Function()? periods,
    List<Experience> Function()? experiences,
    List<EmergencyContact> Function()? emergencyContacts,
  }) {
    return CreationState(
      status: status != null ? status() : this.status,
      allLanguages: allLanguages != null ? allLanguages() : this.allLanguages,
      allLicenses: allLicenses != null ? allLicenses() : this.allLicenses,
      allAreas: allAreas != null ? allAreas() : this.allAreas,
      allFields: allFields != null ? allFields() : this.allFields,
      firstname: firstname != null ? firstname() : this.firstname,
      lastname: lastname != null ? lastname() : this.lastname,
      birthday: birthday != null ? birthday() : this.birthday,
      birthplace: birthplace != null ? birthplace() : this.birthplace,
      nationality: nationality != null ? nationality() : this.nationality,
      address: address != null ? address() : this.address,
      phone: phone != null ? phone() : this.phone,
      email: email != null ? email() : this.email,
      ownCar: ownCar != null ? ownCar() : this.ownCar,
      languages: languages != null ? languages() : this.languages,
      licenses: licenses != null ? licenses() : this.licenses,
      areas: areas != null ? areas() : this.areas,
      fields: fields != null ? fields() : this.fields,
      periods: periods != null ? periods() : this.periods,
      experiences: experiences != null ? experiences() : this.experiences,
      emergencyContacts: emergencyContacts != null
          ? emergencyContacts()
          : this.emergencyContacts,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allFields,
        allLanguages,
        allLicenses,
        allAreas,
        firstname,
        lastname,
        birthday,
        birthplace,
        nationality,
        address,
        phone,
        email,
        ownCar,
        languages,
        licenses,
        areas,
        fields,
        periods,
        experiences,
        emergencyContacts,
      ];
}
