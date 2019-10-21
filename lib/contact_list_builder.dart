import 'package:emailapp/models/Contact.dart';
import 'package:emailapp/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactListBuilder extends StatelessWidget {
  final Function builder;
  final Stream stream;
  const ContactListBuilder({this.builder, this.stream});

  @override
  Widget build(BuildContext context) {
    return Observer(
      stream: stream,
      onSuccess: (BuildContext context, List<Contact> data) {
        return builder(context, data);
      },
      onWaiting: (context) => LinearProgressIndicator(),
    );
  }
}
