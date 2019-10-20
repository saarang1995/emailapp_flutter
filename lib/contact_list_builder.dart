import 'package:emailapp/models/Contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactListBuilder extends StatelessWidget {
  final Stream<List<Contact>> stream;
  final Function builder;

  const ContactListBuilder({ this.builder, this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Contact>>(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              List<Contact> contacts = snapshot.data;
              return builder(context,contacts);
          }
        });
  }
}
