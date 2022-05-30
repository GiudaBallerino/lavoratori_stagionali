// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
      period: Period.fromJson(json['period'] as Map<String, dynamic>),
      company: json['company'] as String,
      task: (json['task'] as List<dynamic>).map((e) => e as String).toList(),
      place: json['place'] as String,
      pay: (json['pay'] as num).toDouble(),
    );

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'period': instance.period,
      'company': instance.company,
      'task': instance.task,
      'place': instance.place,
      'pay': instance.pay,
    };
