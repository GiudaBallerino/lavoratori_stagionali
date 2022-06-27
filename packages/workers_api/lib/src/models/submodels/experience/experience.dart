import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../../workers_api.dart';

part 'experience.g.dart';

@immutable
@JsonSerializable()
class Experience extends Equatable {
  Experience(
      {String? id,
      required this.period,
      required this.company,
      required this.task,
      required this.place,
      required this.pay})
      : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final Period period;
  final String company;
  final List<String> task;
  final String place;
  final double pay;

  Experience copyWith({
    String? id,
    Period? period,
    String? company,
    List<String>? task,
    String? place,
    double? pay,
  }) {
    return Experience(
      id: id ?? this.id,
      period: period ?? this.period,
      company: company ?? this.company,
      task: task ?? this.task,
      place: place ?? this.place,
      pay: pay ?? this.pay,
    );
  }

  static Experience fromJson(JsonMap json) => _$ExperienceFromJson(json);

  JsonMap toJson() => _$ExperienceToJson(this);

  String toString()=>'${this.company} ${this.task.join(' ')}';

  @override
  List<Object> get props => [
        id,
        period,
        company,
        task,
        place,
        pay,
      ];
}
