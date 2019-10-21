import 'package:emailapp/contact_manager.dart';
import 'package:emailapp/provider.dart';
import 'package:emailapp/overseer.dart';
import 'package:flutter/material.dart';

class ContactCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactManager contactManager = Provider.of<OverSeer>(context).fetch(ContactManager);
    return StreamBuilder<int>(
        stream: contactManager.contactCounter,
        builder: (BuildContext context, snapshot) {
          return Chip(
              backgroundColor: Colors.red,
              label: Text(
                (snapshot.data ?? 0).toString(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ));
        });
  }
}
