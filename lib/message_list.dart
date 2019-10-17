import 'dart:convert';

import 'package:emailapp/models/Message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessageList extends StatefulWidget {
  final String title;
  const MessageList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  Future<List<Message>> messages;

  @override
  void initState() {
    super.initState();
    messages = Message.browse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                var _messages = Message.browse();
                setState(() {
                  messages = _messages;
                });
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: messages,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                if (snapshot.hasError)
                  return Text('There was an error !${snapshot.error}');
                var messages = snapshot.data;
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (BuildContext contex, int index) {
                    Message message = messages[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text("PJ"),
                      ),
                      isThreeLine: true,
                      title: Text(message.subject),
                      subtitle: Text(
                        message.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                  itemCount: messages.length,
                );
            }
          },
        ));
  }
}
