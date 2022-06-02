import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:person_abstract_model/person_abstract_model.dart' show Person;

import '../../employees_api.dart';

part 'employee.g.dart';

@immutable
@JsonSerializable()
class Employee extends Person {
  Employee({
    String? id,
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required this.birthday,
    required this.username,
    required this.password,
  }) : super(
            id: id,
            firstname: firstname,
            lastname: lastname,
            email: email,
            phone: phone);

  final DateTime birthday;
  final String username;
  final String password;

  get getId => id;
  get getFirstname => firstname;
  get getLastname => lastname;
  get getPhone => phone;
  get getEmail => email;

  Employee copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    DateTime? birthday,
    String? username,
    String? password,
  }) {
    return Employee(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  static Employee get empty {
    return Employee(
        firstname: '',
        lastname: '',
        email: '',
        phone: '',
        birthday: DateTime.fromMicrosecondsSinceEpoch(0),
        username: '',
        password: '');
  }

  static Employee fromJson(JsonMap json) => _$EmployeeFromJson(json);

  JsonMap toJson() => _$EmployeeToJson(this);

  @override
  List<Object> get props =>
      [id, firstname, lastname, birthday, phone, email, username, password];
}
