import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../../workers_api.dart';

part 'period.g.dart';

@immutable
@JsonSerializable()
class Period extends Equatable {
  Period({
    String? id,
    required this.start,
    required this.end,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
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

  bool include(Period period) {
    if (period.start.isBefore(this.end) && period.end.isAfter(this.start)){
      return true;
    }
    return false;
  }

  static Period fromJson(JsonMap json) => _$PeriodFromJson(json);

  JsonMap toJson() => _$PeriodToJson(this);

  @override
  List<Object> get props => [
        id,
        start,
        end,
      ];
}
