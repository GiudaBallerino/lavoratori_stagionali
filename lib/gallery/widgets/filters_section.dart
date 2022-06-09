import 'package:filters/filters.dart';
import 'package:flutter/material.dart';
import 'package:lavoratori_stagionali/gallery/widgets/selection_list.dart';
import 'package:workers_api/workers_api.dart' show Period;

import '../../creation/widgets/period_list.dart';

class FilterSection extends StatelessWidget {
  const FilterSection(
      {Key? key,
      required this.width,
      required this.filters,
      required this.searchMode,
      required this.changeMode,
      required this.allLanguages,
      required this.allLicenses,
      required this.addLanguages,
      required this.removeLanguages,
      required this.addLicenses,
      required this.removeLicenses,
      required this.allAreas,
      required this.allFields,
      required this.addAreas,
      required this.removeAreas,
      required this.addFields,
      required this.removeFields,
      required this.changeOwnCar,
      required this.addPeriods,
      required this.removePeriods})
      : super(key: key);

  final double width;
  final Filters filters;
  final List<String> allLanguages;
  final List<String> allLicenses;
  final List<String> allAreas;
  final List<String> allFields;
  final bool searchMode;
  final Function() changeMode;
  final Function(String) addLanguages;
  final Function(String) removeLanguages;
  final Function(String) addLicenses;
  final Function(String) removeLicenses;
  final Function(String) addAreas;
  final Function(String) removeAreas;
  final Function(String) addFields;
  final Function(String) removeFields;
  final Function(Period) addPeriods;
  final Function(Period) removePeriods;
  final Function(bool) changeOwnCar;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: SizedBox(
        width: width,
        child: Wrap(
          runSpacing: 10,
          children: [
            SizedBox(
              width: width,
              child: Text(
                'Filtri',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              width: width,
              child: Row(
                children: [
                  Text(
                    'Modalità di ricerca',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () => changeMode(),
                      child: Text(searchMode ? 'OR' : 'AND')),
                ],
              ),
            ),
            SizedBox(
              width: width,
              child: SelectionWidget(
                width: width,
                title: 'Lingue',
                list: allLanguages,
                selected: filters.languages,
                onAdd: (string) => addLanguages(string),
                onDelete: (string) => removeLanguages(string),
              ),
            ),
            SizedBox(
              width: width,
              child: SelectionWidget(
                width: width,
                title: 'Patenti',
                list: allLicenses,
                selected: filters.licenses,
                onAdd: (string) => addLicenses(string),
                onDelete: (string) => removeLicenses(string),
              ),
            ),
            SizedBox(
              width: width,
              child: Row(
                children: [
                  Text(
                    'Automunito',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Checkbox(
                    value: filters.ownCar,
                    onChanged: (bool? value) {
                      if (value != null) {
                        changeOwnCar(value);
                      }
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              width: width,
              child: SelectionWidget(
                width: width,
                title: 'Comuni',
                list: allAreas,
                selected: filters.areas,
                onAdd: (string) => addAreas(string),
                onDelete: (string) => removeAreas(string),
              ),
            ),
            SizedBox(
              width: width,
              child: SelectionWidget(
                width: width,
                title: 'Campi',
                list: allFields,
                selected: filters.fields,
                onAdd: (string) => addFields(string),
                onDelete: (string) => removeFields(string),
              ),
            ),
            SizedBox(
              width: width,
              child: PeriodList(
                hint: 'Aggiungi periodo',
                onAdd: (date) =>
                    addPeriods(Period(start: date.start, end: date.end)),
                width: width,
                title: 'Periodi',
                list: filters.periods,
                onDelete: (period) => removePeriods(period),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
