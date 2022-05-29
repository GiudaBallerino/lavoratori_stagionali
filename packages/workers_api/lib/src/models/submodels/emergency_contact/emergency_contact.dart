import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../../../workers_api.dart';

part 'emergency_contact.g.dart';

@immutable
@JsonSerializable()
class EmergencyContact extends Equatable {
  EmergencyContact(
      {required this.firstname,
      required this.lastname,
      required this.phone,
      required this.email});

  final String firstname;
  final String lastname;
  final String phone;
  final String email;

  EmergencyContact copyWith({
    String? firstname,
    String? lastname,
    String? phone,
    String? email,
  }) {
    return EmergencyContact(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  static EmergencyContact fromJson(JsonMap json) =>
      _$EmergencyContactFromJson(json);

  JsonMap toJson() => _$EmergencyContactToJson(this);

  @override
  List<Object> get props => [
        firstname,
        lastname,
        phone,
        email,
      ];
}
