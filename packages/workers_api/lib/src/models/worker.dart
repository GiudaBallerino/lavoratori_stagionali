import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:person_abstract_model/person_abstract_model.dart';
import 'package:uuid/uuid.dart';
import 'package:workers_api/src/models/submodels/submodels.dart';

import '../../workers_api.dart';

part 'worker.g.dart';

@immutable
@JsonSerializable()
class Worker extends Person {
  Worker({
    String? id,
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required this.birthday,
    required this.birthplace,
    required this.nationality,
    required this.address,
    required this.ownCar,
    required this.languages,
    required this.licenses,
    required this.areas,
    required this.fields,
    required this.experiences,
    required this.periods,
    required this.emergencyContacts,
  }) : super(
            id: id,
            firstname: firstname,
            lastname: lastname,
            email: email,
            phone: phone);


  final DateTime birthday;
  final String birthplace;
  final String nationality;
  final String address;
  final bool ownCar;

  final List<String> languages;
  final List<String> licenses;
  final List<String> areas;
  final List<String> fields;

  final List<Experience> experiences;
  final List<Period> periods;
  final List<EmergencyContact> emergencyContacts;

  get getId => id;
  get getFirstname => firstname;
  get getLastname => lastname;
  get getPhone => phone;
  get getEmail => email;

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
    bool? ownCar,
    List<String>? languages,
    List<String>? licenses,
    List<String>? areas,
    List<String>? fields,
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
      ownCar: ownCar ?? this.ownCar,
      languages: languages ?? this.languages,
      licenses: licenses ?? this.licenses,
      areas: areas ?? this.areas,
      fields: fields ?? this.fields,
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
        ownCar,
        languages,
        licenses,
        areas,
        fields,
        experiences,
        periods,
        emergencyContacts,
      ];
}
