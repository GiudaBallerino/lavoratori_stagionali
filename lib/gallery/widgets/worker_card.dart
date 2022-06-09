import 'package:flutter/material.dart';
import 'package:workers_api/workers_api.dart';

enum Menu {
  Elimina,
  Modifica,
}

class WorkerCard extends StatelessWidget {
  const WorkerCard({
    Key? key,
    required this.worker,
    required this.selected,
    required this.onDelete,
    required this.onSelected,
  }) : super(key: key);

  final Worker worker;
  final bool selected;
  final Function() onDelete;
  final Function() onSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: selected ? Colors.grey[400] : null,
        title: Text('${worker.firstname} ${worker.lastname}',style: TextStyle(fontSize: 20),),
        subtitle: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            for(final field in worker.fields)
              Chip(label: Text(field),),
          ],
        ),
        trailing: PopupMenuButton<Menu>(
            onSelected: (Menu item) {
              if (item == Menu.Elimina) {
                onDelete();
              }
              if (item == Menu.Modifica) {
                //onEdit();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                  for (final action in Menu.values)
                    PopupMenuItem<Menu>(
                      value: action,
                      child: Text(action.name),
                    ),
                ]),
        onTap: () {
          onSelected();
        },
      ),
    );
  }
}
