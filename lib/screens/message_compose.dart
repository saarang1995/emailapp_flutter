import 'package:emailapp/managers/message_form_manager.dart';
import 'package:emailapp/models/Message.dart';
import 'package:emailapp/provider.dart';
import 'package:flutter/material.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {
  @override
  Widget build(BuildContext context) {
    MessageFormManager manager = Provider.of(context).fetch(MessageFormManager);

    return Scaffold(
        appBar: AppBar(
          title: Text('Compose new Message'),
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: <Widget>[
                ListTile(
                    title: StreamBuilder(
                  stream: manager.email$,
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: manager.inEmail.add,
                      decoration: InputDecoration(
                          labelText: 'TO',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          errorText: snapshot.error),
                    );
                  },
                )),
                ListTile(
                  title: StreamBuilder(
                    stream: manager.subject$,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: manager.inSubject.add,
                        decoration: InputDecoration(
                            labelText: 'SUBJECT',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            errorText: snapshot.error),
                      );
                    },
                  ),
                ),
                Divider(),
                ListTile(
                    title: StreamBuilder(
                  stream: manager.body$,
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: manager.inBody.add,
                      decoration: InputDecoration(
                          labelText: 'BODY',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          errorText: snapshot.error),
                      maxLines: 8,
                    );
                  },
                )),
                ListTile(
                    title: StreamBuilder(
                  stream: manager.isFormValid$,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      child: Text('SEND'),
                      onPressed: () {
                        if (snapshot.hasData) {
                          Message message = manager.submit();
                          Navigator.pop(context, message);
                        }
                      },
                    );
                  },
                ))
              ],
            ),
          ),
        ));
  }
}
