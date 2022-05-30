import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workers_api/workers_api.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({Key? key,required this.width, required this.experience}) : super(key: key);

  final double width;
  final Experience experience;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.5,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                experience.company,
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Da: ${DateFormat('dd/MM/yyyy').format(experience.period.start)} - A: ${DateFormat('dd/MM/yyyy').format(experience.period.end)}\n${experience.place}'),
            ),
            ListTile(
              title: Text('Mansioni:'),
              subtitle: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  for (final task in experience.task) Chip(label: Text(task))
                ],
              ),
            ),
            ListTile(
              title: Text(
                  'Paga giornaliera lorda:'), //Text(element.company),
              trailing: Text('€${experience.pay}'),
            ),
          ],
        ),
      ),
    );
  }
}
