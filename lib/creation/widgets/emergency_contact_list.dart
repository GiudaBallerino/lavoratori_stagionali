import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workers_api/workers_api.dart';

class EmergencyContactList extends StatelessWidget {
  const EmergencyContactList({
    Key? key,
    required this.title,
    required this.hint,
    required this.width,
    required this.height,
    required this.list,
    required this.onAdd,
    required this.onDelete,
  }) : super(key: key);

  final String title;
  final String hint;
  final double width;
  final double height;
  final List<EmergencyContact> list;
  final Function(EmergencyContact) onAdd;
  final Function(EmergencyContact) onDelete;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        SizedBox(
          width: width,
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              InkWell(
                child: Icon(Icons.add_circle),
                onTap: () async {
                  final EmergencyContact? result =
                      await showEmergencyContactBuilder(context);
                  if (result != null) {
                    onAdd(result);
                  }
                },
              ),
            ],
          ),
        ),
        if (list.isEmpty)
          SizedBox(
            width: width * 0.25,
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      "Nessun contatto inserito",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        for (final element in list)
          SizedBox(
            width: width * 0.25,
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      '${element.firstname} ${element.lastname}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    trailing: InkWell(
                      child: Icon(Icons.cancel),
                      onTap: () {
                        onDelete(element);
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Contatti:'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Chip(label: Text(element.email)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Chip(label: Text(element.phone)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Future<EmergencyContact?> showEmergencyContactBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        TextEditingController _firstname = TextEditingController();
        TextEditingController _lastname = TextEditingController();
        TextEditingController _phone = TextEditingController();
        TextEditingController _email = TextEditingController();
        return Dialog(
          child: SizedBox(
            width: width * 0.5,
            height: height * 0.5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    hint,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.25 - 22,
                        child: TextField(
                          controller: _firstname,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Nome',
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.25 - 22,
                        child: TextField(
                          controller: _lastname,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Cognome',
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: width * 0.125 - 12,
                        child: TextField(
                          controller: _phone,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Cellulare',
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.125 - 12,
                        child: TextField(
                          controller: _email,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(null);
                        },
                        child: Text('Annulla'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          EmergencyContact result = EmergencyContact(
                              firstname: _firstname.text,
                              lastname: _lastname.text,
                              phone: _phone.text,
                              email: _email.text);
                          Navigator.of(context).pop(result);
                        },
                        child: Text('Conferma'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
