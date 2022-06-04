import 'package:flutter/material.dart';
import 'package:workers_api/workers_api.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.width, required this.contact}) : super(key: key);

  final double width;
  final EmergencyContact contact;

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
                '${contact.firstname} ${contact.lastname}',
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text('Contatti:'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal:5),
                    child: Chip(label: Text(contact.email)),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal:5),
                    child: Chip(label: Text(contact.phone)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
