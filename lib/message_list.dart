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
  List<Message> messages = const [];

  Future loadMessageList() async {
    // String content = await rootBundle.loadString('data/message.json');
    http.Response response =
        await http.get('http://www.mocky.io/v2/5da864c71200001100edae5f');
    String content = response.body;
    List collection = json.decode(content);
    List<Message> _messages =
        collection.map((json) => Message.fromJson(json)).toList();

    setState(() {
      messages = _messages;
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
      ),
    );
  }
}
