import 'package:emailapp/managers/message_form_manager.dart';
import 'package:emailapp/models/Message.dart';
import 'package:emailapp/observer.dart';
import 'package:emailapp/provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {
  String to = "";
  String subject = "";
  String body = "";
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    MessageFormManager manager = Provider.of(context).fetch(MessageFormManager);

    return Scaffold(
        appBar: AppBar(
          title: Text('Compose new Message'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                ListTile(
                    title: Observer(
                  stream: manager.email$,
                  onSuccess: (context, data) {
                    return TextField(
                      onChanged: manager.inEmail.add,
                      decoration: InputDecoration(
                          labelText: 'TO',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  },
                  onError: (context, error) {
                    return TextField(
                      decoration: InputDecoration(
                          labelText: 'TO ()',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          errorText: "This field is invalid"),
                    );
                  },
                )),
                ListTile(
                  title: TextFormField(
                    validator: (value) {
                      int len = value.length;
                      if (len == 0) {
                        return '`SUBJECT` cannot be empty';
                      } else if (len < 4) {
                        return '`SUBJECT` must be longer than 4 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'SUBJECT',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    onSaved: (value) => subject = value,
                  ),
                ),
                Divider(),
                ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'BODY',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    maxLines: 8,
                    onSaved: (value) => body = value,
                  ),
                ),
                ListTile(
                    title: RaisedButton(
                  child: Text('SEND'),
                  onPressed: () {
                    if (key.currentState.validate()) {
                      key.currentState.save();
                      Message message = Message(subject, body);
                      Navigator.pop(context, message);
                    }
                  },
                ))
              ],
            ),
          ),
        ));
  }
}
