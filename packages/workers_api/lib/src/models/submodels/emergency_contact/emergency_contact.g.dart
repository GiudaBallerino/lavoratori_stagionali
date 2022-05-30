// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyContact _$EmergencyContactFromJson(Map<String, dynamic> json) =>
    EmergencyContact(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$EmergencyContactToJson(EmergencyContact instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'phone': instance.phone,
      'email': instance.email,
    };
