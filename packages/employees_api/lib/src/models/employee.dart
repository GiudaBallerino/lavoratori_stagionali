import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../employees_api.dart';

part 'employee.g.dart';

@immutable
@JsonSerializable()
class Employee extends Equatable {
  const Employee({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.username,
    required this.password,
  });

  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final DateTime? birthday;
  final String username;
  final String password;

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
  static const Employee empty = Employee(
      id: '',
      firstname: '',
      lastname: '',
      email: '',
      phone: '',
      birthday: null,
      username: '',
      password: '');

  bool get isEmpty => this == Employee.empty;

  bool get isNotEmpty => this != Employee.empty;

  static Employee fromJson(JsonMap json) => _$EmployeeFromJson(json);

  JsonMap toJson() => _$EmployeeToJson(this);

  @override
  List<Object?> get props =>
      [id, firstname, lastname, birthday, phone, email, username, password];
}
