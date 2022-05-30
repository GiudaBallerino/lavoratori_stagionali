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
    this.focusNode,
    this.firstname,
    this.lastname,
    this.birthday,
    this.birthplace,
    this.nationality,
    this.address,
    this.phone,
    this.email,
    this.languages = const [],
    this.licenses = const [],
    this.areas = const [],
    this.tasks = const [],
    this.periods = const [],
    this.experiences = const [],
    this.emergencyContacts = const [],
  });

  final CreationStatus status;
  final FocusNode? focusNode;
  final String? firstname;
  final String? lastname;
  final DateTime? birthday;
  final String? birthplace;
  final String? nationality;
  final String? address;
  final String? phone;
  final String? email;
  final List<String> languages;
  final List<String> licenses;
  final List<String> areas;
  final List<String> tasks;
  final List<Period> periods;
  final List<Experience> experiences;
  final List<EmergencyContact> emergencyContacts;

  CreationState copyWith({
    CreationStatus Function()? status,
    String? Function()? firstname,
    String? Function()? lastname,
    DateTime? Function()? birthday,
    String? Function()? birthplace,
    String? Function()? nationality,
    String? Function()? address,
    String? Function()? phone,
    String? Function()? email,
    List<String> Function()? languages,
    List<String> Function()? licenses,
    List<String> Function()? areas,
    List<String> Function()? tasks,
    List<Period> Function()? periods,
    List<Experience> Function()? experiences,
    List<EmergencyContact> Function()? emergencyContacts,
  }) {
    return CreationState(
      status: status != null ? status() : this.status,
      firstname: firstname != null ? firstname() : this.firstname,
      lastname: lastname != null ? lastname() : this.lastname,
      birthday: birthday != null ? birthday() : this.birthday,
      birthplace: birthplace != null ? birthplace() : this.birthplace,
      nationality: nationality != null ? nationality() : this.nationality,
      address: address != null ? address() : this.address,
      phone: phone != null ? phone() : this.phone,
      email: email != null ? email() : this.email,
      languages: languages != null ? languages() : this.languages,
      licenses: licenses != null ? licenses() : this.licenses,
      areas: areas != null ? areas() : this.areas,
      tasks: tasks != null ? tasks() : this.tasks,
      periods: periods != null ? periods() : this.periods,
      experiences: experiences != null ? experiences() : this.experiences,
      emergencyContacts: emergencyContacts != null ? emergencyContacts() : this.emergencyContacts,
    );
  }

  @override
  List<Object?> get props => [
        status,
        firstname,
        lastname,
        birthday,
        birthplace,
        nationality,
        address,
        phone,
        email,
        languages,
        licenses,
        areas,
        tasks,
        periods,
        experiences,
        emergencyContacts,
      ];
}
