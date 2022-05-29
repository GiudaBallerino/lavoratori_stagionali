import 'package:flutter/material.dart';

class ChipList extends StatelessWidget {
  ChipList({
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
  final List<String> list;
  final Function(String) onAdd;
  final Function(String) onDelete;

  TextEditingController _controller= TextEditingController();
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
            onDeleted: () => onDelete(element),
            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 13),
          ),
        IntrinsicWidth(
          child: TextField(
            controller: _controller,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
              suffixIcon: InkWell(
                onTap: () {
                  if (!_controller.text.isEmpty)
                    onAdd(_controller.text);
                },
                child: Icon(
                  Icons.add_circle,
                ),
              ),
            ),
            onSubmitted: (text) {
              if (!_controller.text.isEmpty)
                onAdd(_controller.text);
            },
          ),
        ),
      ],
    );
  }
}
