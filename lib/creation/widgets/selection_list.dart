import 'package:flutter/material.dart';

class SelectionList extends StatelessWidget {
  SelectionList({
    Key? key,
    required this.title,
    required this.hint,
    required this.width,
    required this.selected,
    required this.onAdd,
    required this.onDelete,
    required this.list,
  }) : super(key: key);

  final String title;
  final String hint;
  final double width;
  final List<String> selected;
  final List<String> list;
  final Function(String) onAdd;
  final Function(String) onDelete;

  TextEditingController _controller = TextEditingController();
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
        IntrinsicWidth(
          child: TextField(
            controller: _controller,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              suffixIcon: InkWell(
                onTap: () {
                  if (!_controller.text.isEmpty) onAdd(_controller.text);
                },
                child: Icon(
                  Icons.add_circle,
                ),
              ),
            ),
            onSubmitted: (text) {
              if (!_controller.text.isEmpty) onAdd(_controller.text);
            },
          ),
        ),
        for (final element in items)
            InputChip(
              label: Text(element),
              selected: selected.contains(element),
              onPressed: selected.contains(element)
                  ? () => onDelete(element)
                  : () => onAdd(element),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            ),
      ],
    );
  }

  Set get items {
    List<String> items = [...selected, ...list];

    return items.toSet();
  }
}
