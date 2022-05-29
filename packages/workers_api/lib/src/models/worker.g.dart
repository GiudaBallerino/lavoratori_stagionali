// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Worker _$WorkerFromJson(Map<String, dynamic> json) => Worker(
      id: json['id'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      birthday: json['birthday'] as DateTime,
      birthplace: json['birthplace'] as String,
      nationality: json['nationality'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      languages:
          List.from(json['languages']).map((item) => item as String).toList(),
      licenses:
          List.from(json['licenses']).map((item) => item as String).toList(),
      areas: List.from(json['areas']).map((item) => item as String).toList(),
      tasks: List.from(json['tasks']).map((item) => item as String).toList(),
      experiences: List.from(json['experiences'])
          .map((item) => Experience.fromJson(item))
          .toList(),
      periods: List.from(json['periods'])
          .map((item) => Period.fromJson(item))
          .toList(),
      emergencyContacts: List.from(json['emergencyContacts'])
          .map((item) => EmergencyContact.fromJson(item))
          .toList(),
    );

Map<String, dynamic> _$WorkerToJson(Worker instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'birthday': instance.birthday,
      'birthplace': instance.birthplace,
      'nationality': instance.nationality,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'languages': instance.languages,
      'licenses': instance.licenses,
      'areas': instance.areas,
      'tasks': instance.tasks,
      'experiences':instance.experiences.map((e)=>e.toJson()).toList(),
      'periods':instance.periods.map((p)=>p.toJson()).toList(),
      'emergencyContacts':instance.experiences.map((e)=>e.toJson()).toList(),
    };
