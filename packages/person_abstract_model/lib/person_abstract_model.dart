library person_abstract_model;

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class Person extends Equatable {
  Person({
    String? id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.email,
  })  : assert(
  id == null || id.isNotEmpty,
  'id can not be null and should be empty',
  ),
        id = id ?? const Uuid().v4();

  final String id;
  final String firstname;
  final String lastname;
  final String phone;
  final String email;


  @override
  List<Object> get props => [
    id,
    firstname,
    lastname,
    phone,
    email,
  ];
}
