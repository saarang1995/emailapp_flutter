import 'package:emailapp/managers/contact_manager.dart';
import 'package:emailapp/observer.dart';
import 'package:emailapp/provider.dart';
import 'package:flutter/material.dart';

class ContactCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactManager contactManager = Provider.of(context).fetch(ContactManager);
    return Observer(
        stream: contactManager.count$,
        onSuccess: (BuildContext context, data) {
          return Chip(
              backgroundColor: Colors.red,
              label: Text(
                (data ?? 0).toString(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ));
        });
  }
}
