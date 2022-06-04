import 'package:flutter/material.dart';

class SelectionWidget extends StatelessWidget {
  SelectionWidget({
    Key? key,
    required this.title,
    required this.width,
    required this.selected,
    required this.onAdd,
    required this.onDelete,
    required this.list,
  }) : super(key: key);

  final String title;
  final double width;
  final List<String> selected;
  final List<String> list;
  final Function(String) onAdd;
  final Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        SizedBox(
          width: width,
          child: Text(title,style:
          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
        ),
        for (final element in list)
          InputChip(
            label: Text(element),
            selected: selected.contains(element),
            onPressed: selected.contains(element)?() => onDelete(element):()=>onAdd(element),
            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 13),
          ),
      ],
    );
  }
}
