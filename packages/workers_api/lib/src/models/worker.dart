import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:workers_api/src/models/submodels/submodels.dart';

import '../../workers_api.dart';

part 'worker.g.dart';

@immutable
@JsonSerializable()
class Worker extends Equatable {
  Worker({
    String? id,
    required this.firstname,
    required this.lastname,
    required this.birthday,
    required this.birthplace,
    required this.nationality,
    required this.address,
    required this.phone,
    required this.email,
    required this.languages,
    required this.licenses,
    required this.areas,
    required this.tasks,
    required this.experiences,
    required this.periods,
    required this.emergencyContacts,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String firstname;
  final String lastname;
  final DateTime birthday;
  final String birthplace;
  final String nationality;
  final String address;
  final String phone;
  final String email;

  final List<String> languages;
  final List<String> licenses;
  final List<String> areas;
  final List<String> tasks;

  final List<Experience> experiences;
  final List<Period> periods;
  final List<EmergencyContact> emergencyContacts;

  Worker copyWith({
    String? id,
    String? firstname,
    String? lastname,
    DateTime? birthday,
    String? birthplace,
    String? nationality,
    String? address,
    String? phone,
    String? email,
    List<String>? languages,
    List<String>? licenses,
    List<String>? areas,
    List<String>? tasks,
    List<Experience>? experiences,
    List<Period>? periods,
    List<EmergencyContact>? emergencyContacts,
  }) {
    return Worker(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      birthday: birthday ?? this.birthday,
      birthplace: birthplace ?? this.birthplace,
      nationality: nationality ?? this.nationality,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      languages: languages ?? this.languages,
      licenses: licenses ?? this.licenses,
      areas: areas ?? this.areas,
      tasks: tasks ?? this.tasks,
      experiences: experiences ?? this.experiences,
      periods: periods ?? this.periods,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
    );
  }

  static Worker fromJson(JsonMap json) => _$WorkerFromJson(json);

  JsonMap toJson() => _$WorkerToJson(this);

  @override
  List<Object> get props => [
        id,
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
        experiences,
        periods,
        emergencyContacts,
      ];
}
