import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workers_api/workers_api.dart' show Worker;

import 'contact_card.dart';
import 'experience_card.dart';

class WorkerSection extends StatelessWidget {
  const WorkerSection({Key? key,required this.width,required this.worker}) : super(key: key);

  final double width;
  final Worker worker;
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      controller: ScrollController(),
      child: SizedBox(
        width: width,
        child: Wrap(
          children: [
            SizedBox(
              width: width,
              child: Text(
                '${worker.firstname} ${worker.lastname}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              width: width*0.5,
              child: Text(
                'e-mail: ${worker.email}',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: width*0.5,
              child: Text(
                'Nato il: ${DateFormat('dd/MM/yyyy').format(worker.birthday)}',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: width*0.5,
              child: Text(
                'telefono: ${worker.phone}',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: width*0.5,
              child: Text(
                'A: ${worker.birthplace}',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: width*0.5,
              child: Text(
                'indirizzo: ${worker.address}',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: width*0.5,
              child: Text(
                'Nazionalità: ${worker.nationality}',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(),
            SizedBox(
              width: width*0.5,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  SizedBox(
                    width: width*0.5,
                    child: Text(
                      'Lingue parlate:',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  for (final lang
                  in worker.languages)
                    Chip(
                      label: Text(lang),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: width*0.5,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  SizedBox(
                    width: width*0.58,
                    child: Text(
                      'Patenti:',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  for (final lic in worker.licenses)
                    Chip(
                      label: Text(lic),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: width*0.5,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  SizedBox(
                    width: width*0.5,
                    child: Text(
                      'Zone:',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  for (final area in worker.areas)
                    Chip(
                      label: Text(area),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: width*0.5,
              child: Row(
                children: [
                  Text(
                    'Automunito',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Checkbox(
                    value: worker.ownCar,
                    onChanged: (value) {},
                  )
                ],
              ),
            ),
            SizedBox(
              width: width*0.5,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  SizedBox(
                    width: width*0.5,
                    child: Text(
                      'Specializzazioni:',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  for (final field in worker.fields)
                    Chip(
                      label: Text(field),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: width*0.5,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  SizedBox(
                    width: width*0.5,
                    child: Text(
                      'Periodi:',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  for (final period
                  in worker.periods)
                    Chip(
                      label: Text(
                          '${DateFormat('dd/MM').format(period.start)} - ${DateFormat('dd/MM').format(period.end)}'),
                    ),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              width: width,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  SizedBox(
                    width: width,
                    child: Text(
                      'Esperienze:',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  for (final experience
                  in worker.experiences)
                    ExperienceCard(
                        width: width,
                        experience: experience),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              width: width,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  SizedBox(
                    width: width,
                    child: Text(
                      'Contatti di emergenza:',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  for (final contact
                  in worker.emergencyContacts)
                    ContactCard(
                        width: width,
                        contact: contact),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
