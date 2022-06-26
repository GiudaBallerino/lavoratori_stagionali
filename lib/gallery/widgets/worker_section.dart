import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lavoratori_stagionali/gallery/widgets/simple_text.dart';
import 'package:workers_api/workers_api.dart' show Worker;

import 'contact_card.dart';
import 'experience_card.dart';

class WorkerSection extends StatelessWidget {
  const WorkerSection({
    Key? key,
    required this.width,
    required this.worker,
  }) : super(key: key);

  final double width;
  final Worker worker;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: SizedBox(
        width: width,
        child: Wrap(
          children: [
            SimpleText(
              width: width,
              text: '${worker.firstname} ${worker.lastname}',
              fontSize: 20,
            ),
            SimpleText(
              width: width * 0.5,
              text: 'E-mail: ${worker.email}',
              fontSize: 15,
            ),
            SimpleText(
              width: width * 0.5,
              text:
                  'Nato il: ${DateFormat('dd/MM/yyyy').format(worker.birthday)}',
              fontSize: 15,
            ),
            SimpleText(
              width: width * 0.5,
              text: 'Telefono: ${worker.phone}',
              fontSize: 15,
            ),
            SimpleText(
              width: width * 0.5,
              text: 'A: ${worker.birthplace}',
              fontSize: 15,
            ),
            SimpleText(
              width: width * 0.5,
              text: 'Indirizzo: ${worker.address}',
              fontSize: 15,
            ),
            SimpleText(
              width: width * 0.5,
              text: 'Nazionalità: ${worker.nationality}',
              fontSize: 15,
            ),
            Divider(),
            SizedBox(
              width: width * 0.5,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  SimpleText(
                    width: width * 0.5,
                    text: 'Lingue parlate:',
                    fontSize: 15,
                  ),
                  for (final lang in worker.languages)
                    Chip(
                      label: Text(lang),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.5,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  SimpleText(
                    width: width * 0.58,
                    text: 'Patenti:',
                    fontSize: 15,
                  ),
                  for (final lic in worker.licenses)
                    Chip(
                      label: Text(lic),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.5,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  SimpleText(
                    width: width * 0.5,
                    text: 'Zone:',
                    fontSize: 15,
                  ),
                  for (final area in worker.areas)
                    Chip(
                      label: Text(area),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.5,
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
              width: width * 0.5,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  SimpleText(
                    width: width * 0.5,
                    text: 'Specializzazioni:',
                    fontSize: 15,
                  ),
                  for (final field in worker.fields)
                    Chip(
                      label: Text(field),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.5,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  SimpleText(
                    width: width * 0.5,
                    text: 'Periodi:',
                    fontSize: 15,
                  ),
                  for (final period in worker.periods)
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
                  SimpleText(
                    width: width,
                    text: 'Esperienze:',
                    fontSize: 15,
                  ),
                  for (final experience in worker.experiences)
                    ExperienceCard(width: width, experience: experience),
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
                  SimpleText(
                    width: width,
                    text: 'Contatti di emergenza:',
                    fontSize: 15,
                  ),
                  for (final contact in worker.emergencyContacts)
                    ContactCard(width: width, contact: contact),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
