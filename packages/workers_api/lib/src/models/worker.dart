import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../workers_api.dart';

part 'worker.g.dart';

@immutable
@JsonSerializable()
class Worker extends Equatable {
  Worker({
    String? id,
    required this.firstname,
    required this.lastname
  }) :assert(id == null || id.isNotEmpty, 'id can not be null and should be empty',), id = id ?? const Uuid().v4();

  final String id;
  String firstname;
  String lastname;

  Worker copyWith({
    String? id,
    String? firstname,
    String? lastname,
  }) {
    return Worker(
        id: id ?? this.id,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
    );
  }

  static Worker fromJson(JsonMap json) => _$WorkerFromJson(json);

  JsonMap toJson() => _$WorkerToJson(this);

  @override
  List<Object> get props => [id, firstname, lastname];
}