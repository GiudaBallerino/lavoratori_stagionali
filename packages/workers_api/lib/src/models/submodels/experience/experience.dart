import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../../../workers_api.dart';
import '../period/models.dart';

part 'experience.g.dart';

@immutable
@JsonSerializable()
class Experience extends Equatable {
  Experience(
      {
        required this.period,
        required this.company,
        required this.task,
        required this.place,
        required this.pay});

  final Period period;
  final String company;
  final List<String> task;
  final String place;
  final double pay;

  Experience copyWith({
    Period? period,
    String? company,
    List<String>? task,
    String? place,
    double? pay,
  }) {
    return Experience(
      period: period ?? this.period,
      company: company ?? this.company,
      task: task ?? this.task,
      place: place ?? this.place,
      pay: pay ?? this.pay,
    );
  }

  static Experience fromJson(JsonMap json) =>
      _$ExperienceFromJson(json);

  JsonMap toJson() => _$ExperienceToJson(this);

  @override
  List<Object> get props => [
    period,
    company,
    task,
    place,
    pay,
  ];
}
