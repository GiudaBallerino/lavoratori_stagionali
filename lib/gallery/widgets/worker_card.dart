import 'package:flutter/material.dart';
import 'package:workers_api/workers_api.dart';

enum Menu {
  Elimina,
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
            for(final task in worker.tasks)
              Chip(label: Text(task),),
          ],
        ),
        trailing: PopupMenuButton<Menu>(
            onSelected: (Menu item) {
              if (item == Menu.Elimina) {
                onDelete();
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
