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
    required this.scaffoldKey,
  }) : super(key: key);

  final String title;
  final String hint;
  final double width;
  final double height;
  final List<Experience> list;
  final Function(Experience) onAdd;
  final Function(Experience) onDelete;
  final GlobalKey<ScaffoldState> scaffoldKey;

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
                      await showExperienceBuilder(scaffoldKey);
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
                      "Nessuna esperienza inserita",
                      // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      element.company,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    trailing: InkWell(
                      child: Icon(Icons.cancel),
                      onTap: () {
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
                    title: Text('Paga giornaliera lorda:'),
                    trailing: Text('€${element.pay}'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Future<Experience?> showExperienceBuilder(final GlobalKey<ScaffoldState> scaffoldKey) {
    return showDialog(
      context: scaffoldKey.currentContext!,
      builder: (_) {
        final _formKey = GlobalKey<FormState>();
        TextEditingController _company = TextEditingController();
        TextEditingController _start = TextEditingController();
        TextEditingController _end = TextEditingController();
        TextEditingController _place = TextEditingController();
        TextEditingController _tasks = TextEditingController();
        TextEditingController _pay = TextEditingController();
        return Dialog(
          child: SizedBox(
            width: width * 0.5,
            height: height * 0.6,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      hint,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
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
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Campo obbligatorio';
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.25 - 22,
                          child: TextFormField(
                            controller: _start,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Inizio periodo (gg/mm/aaaa)',
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Campo obbligatorio';
                              try {
                                DateFormat('dd/MM/yyyy').parse(value);
                              } catch (e) {
                                return 'Inserire una data valida';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: width * 0.25 - 22,
                          child: TextFormField(
                            controller: _end,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Fine periodo (gg/mm/aaaa)',
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Campo obbligatorio';
                              try {
                                DateFormat('dd/MM/yyyy').parse(value);
                              } catch (e) {
                                return 'Inserire una data valida';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.25 - 22,
                          child: TextFormField(
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
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Campo obbligatorio';
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: width * 0.25 - 22,
                          child: TextFormField(
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
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Campo obbligatorio';
                              try {
                                double.parse(value);
                              } catch (e) {
                                return 'Inserire un numero valido';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
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
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Campo obbligatorio';
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(_).pop(null);
                          },
                          child: Text('Annulla'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Experience exp = Experience(
                                  period: Period(
                                      start: DateFormat('dd/MM/yyyy').parse(_start.text),
                                      end: DateFormat('dd/MM/yyyy').parse(_end.text)),
                                  company: _company.text,
                                  task: _tasks.text.split('|'),
                                  place: _place.text,
                                  pay: double.parse(_pay.text));
                              Navigator.of(_).pop(exp);
                            }
                          },
                          child: Text('Conferma'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
