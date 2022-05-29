// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
      period: Period.fromJson(json['period']),
      company: json['company'] as String,
      task: List.from(json['task']).map((item) => item as String).toList(),
      place: json['place'] as String,
      pay: json['pay'] as double,
    );

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'period': instance.period.toJson(),
      'company': instance.company,
      'task': instance.task,
      'place': instance.place,
      'pay': instance.pay,
    };
