import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workers_api/workers_api.dart' show Period;

class PeriodList extends StatelessWidget {
  const PeriodList({
    Key? key,
    required this.title,
    required this.hint,
    required this.width,
    required this.list,
    required this.onAdd,
    required this.onDelete,
  }) : super(key: key);

  final String title;
  final String hint;
  final double width;
  final List<Period> list;
  final Function(DateTimeRange) onAdd;
  final Function(Period) onDelete;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        SizedBox(
          width: width,
          child: Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        for (final element in list)
          InputChip(
            label: Text(
                'Da: ${DateFormat('dd/MM/yyyy').format(element.start)} - A: ${DateFormat('dd/MM/yyyy').format(element.end)}'),
            onDeleted: () =>onDelete(element),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          ),
        InputChip(
          label: Text(hint),
          onPressed: () async {
            final DateTimeRange? result = await showDateRangePicker(
              context: context,
              initialEntryMode: DatePickerEntryMode.calendar,
              firstDate: DateTime.now(),
              lastDate: DateTime(2030, 12, 31),
              currentDate: DateTime.now(),
              helpText: 'SELEZIONA DATE',
              fieldStartHintText: 'Data di inizio',
              fieldEndLabelText: 'Data di inizio',
              fieldEndHintText: 'Data di fine',
              fieldStartLabelText: 'Data di fine',
              saveText: 'Fatto',
            );

            if (result != null) {
              onAdd(result);
            }
          },
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        ),
      ],
    );
  }
}
