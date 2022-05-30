import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workers_api/workers_api.dart';

class ExperienceList extends StatelessWidget {
  const ExperienceList({
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
  final List<Experience> list;
  final Function(Experience) onAdd;
  final Function(Experience) onDelete;

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
                  final Experience? result =
                      await showExperienceBuilder(context);
                  if (result != null) {
                    onAdd(result);
                  }
                },
              ),
            ],
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
                      element.company,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    trailing: InkWell(
                      child: Icon(Icons.cancel),
                      onTap: (){
                        onDelete(element);
                      },
                    ),
                    subtitle: Text(
                        'Da: ${DateFormat('dd/MM/yyyy').format(element.period.start)} - A: ${DateFormat('dd/MM/yyyy').format(element.period.end)}\n${element.place}'),
                  ),
                  ListTile(
                    title: Text('Mansioni:'),
                    subtitle: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (final task in element.task) Chip(label: Text(task))
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                        'Paga giornaliera lorda:'), //Text(element.company),
                    trailing: Text('€${element.pay}'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Future<Experience?> showExperienceBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        TextEditingController _company = TextEditingController();
        TextEditingController _start = TextEditingController();
        TextEditingController _end = TextEditingController();
        TextEditingController _place = TextEditingController();
        TextEditingController _tasks = TextEditingController();
        TextEditingController _pay = TextEditingController();
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
                  TextField(
                    controller: _company,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Azienda',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.25 - 22,
                        child: TextField(
                          controller: _start,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Inizio periodo (GG/MM/AAAA)',
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
                          controller: _end,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Fine periodo (GG/MM/AAAA)',
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
                          controller: _place,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Luogo',
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
                          controller: _pay,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Paga giornaliera lorda',
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
                  TextField(
                    controller: _tasks,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText:
                          'Mansioni separate da | (esempio: "Agricoltore|Contadino|Trattorista").',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    minLines: 1,
                    maxLines: 2,
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
                          Experience exp = Experience(
                              period: Period(
                                  start: DateFormat('dd/MM/yyyy')
                                      .parse(_start.text),
                                  end: DateFormat('dd/MM/yyyy')
                                      .parse(_end.text)),
                              company: _company.text,
                              task: _tasks.text.split('|'),
                              place: _place.text,
                              pay: double.parse(_pay.text));
                          Navigator.of(context).pop(exp);
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
