import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageList extends StatefulWidget {
  final String title;
  const MessageList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List<dynamic> messages = const [];

  Future loadMessageList() async {
    String content = await rootBundle.loadString('data/message.json');
    List<dynamic> collection = json.decode(content);
    setState(() {
      messages = collection;
    });
  }

  @override
  void initState() {
    loadMessageList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (BuildContext contex, int index) {
          Map message = messages[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text("PJ"),
            ),
            isThreeLine: true,
            title: Text(message['subject']),
            subtitle: Text(
              message['body'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        itemCount: messages.length,
      ),
    );
  }
}
