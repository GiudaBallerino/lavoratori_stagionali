import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../../../workers_api.dart';

part 'period.g.dart';

@immutable
@JsonSerializable()
class Period extends Equatable {
  Period({
    required this.start,
    required this.end,
  });

  final DateTime start;
  final DateTime end;

  Period copyWith({
    DateTime? start,
    DateTime? end,
  }) {
    return Period(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  static Period fromJson(JsonMap json) => _$PeriodFromJson(json);

  JsonMap toJson() => _$PeriodToJson(this);

  @override
  List<Object> get props => [
        start,
        end,
      ];
}
