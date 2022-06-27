import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:person_abstract_model/person_abstract_model.dart';

import '../../../../workers_api.dart';

part 'emergency_contact.g.dart';

@immutable
@JsonSerializable()
class EmergencyContact extends Person {
  EmergencyContact(
      {String? id,
      required String firstname,
      required String lastname,
      required String phone,
      required String email})
      : super(
            id: id,
            firstname: firstname,
            lastname: lastname,
            phone: phone,
            email: email);

  get getId => id;
  get getFirstname => firstname;
  get getLastname => lastname;
  get getPhone => phone;
  get getEmail => email;

  EmergencyContact copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? phone,
    String? email,
  }) {
    return EmergencyContact(
      id: id ?? this.id,
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
        id,
        firstname,
        lastname,
        phone,
        email,
      ];
}
