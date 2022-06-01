// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Worker _$WorkerFromJson(Map<String, dynamic> json) => Worker(
      id: json['id'] as String?,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      birthday: DateTime.parse(json['birthday'] as String),
      birthplace: json['birthplace'] as String,
      nationality: json['nationality'] as String,
      address: json['address'] as String,
      ownCar: json['ownCar'] as bool,
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      licenses:
          (json['licenses'] as List<dynamic>).map((e) => e as String).toList(),
      areas: (json['areas'] as List<dynamic>).map((e) => e as String).toList(),
      fields:
          (json['fields'] as List<dynamic>).map((e) => e as String).toList(),
      experiences: (json['experiences'] as List<dynamic>)
          .map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
      periods: (json['periods'] as List<dynamic>)
          .map((e) => Period.fromJson(e as Map<String, dynamic>))
          .toList(),
      emergencyContacts: (json['emergencyContacts'] as List<dynamic>)
          .map((e) => EmergencyContact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkerToJson(Worker instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'phone': instance.phone,
      'email': instance.email,
      'birthday': instance.birthday.toIso8601String(),
      'birthplace': instance.birthplace,
      'nationality': instance.nationality,
      'address': instance.address,
      'ownCar': instance.ownCar,
      'languages': instance.languages,
      'licenses': instance.licenses,
      'areas': instance.areas,
      'fields': instance.fields,
      'experiences': instance.experiences,
      'periods': instance.periods,
      'emergencyContacts': instance.emergencyContacts,
    };
