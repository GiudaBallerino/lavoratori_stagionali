library filters;

import 'package:workers_api/workers_api.dart' show Period;

class Filters {
  const Filters({
    required this.keywords,
    required this.fields,
    required this.languages,
    required this.areas,
    required this.ownCar,
    required this.licenses,
    required this.periods,
  });

  final String keywords;
  final List<String> fields;
  final List<String> languages;
  final List<String> areas;
  final List<String> licenses;
  final bool ownCar;
  final List<Period> periods;

  Filters copyWith({
    String? keywords,
    List<String>? fields,
    List<String>? languages,
    List<String>? licenses,
    List<String>? areas,
    bool? ownCar,
    List<Period>? periods,
  }) {
    return Filters(
      keywords: keywords ?? this.keywords,
      fields: fields ?? this.fields,
      languages: languages ?? this.languages,
      licenses: licenses ?? this.licenses,
      areas: areas ?? this.areas,
      ownCar: ownCar ?? this.ownCar,
      periods: periods ?? this.periods,
    );
  }

  static const Filters empty = Filters(
      keywords: '',
      fields: [],
      languages: [],
      areas: [],
      ownCar: false,
      licenses: [],
      periods: []);

  bool get isEmpty =>
      this.keywords == '' &&
      this.fields.isEmpty &&
      this.languages.isEmpty &&
      this.areas.isEmpty &&
      !this.ownCar &&
      this.licenses.isEmpty &&
      this.periods.isEmpty;

  bool get isNotEmpty => this != Filters.empty;

  List<Object?> get props =>
      [keywords, fields, languages, areas, ownCar, licenses, periods];
}
