import 'package:emailapp/compose_button.dart';
import 'package:emailapp/message_detail.dart';
import 'package:emailapp/models/Message.dart';
import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  final String title;
  const MessageList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  Future<List<Message>> future;
  List<Message> messages;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    future = Message.browse();
    messages = await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                var _messages = await Message.browse();
                setState(() {
                  messages = _messages;
                });
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: future,
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MessageDetail(
                                        message.subject, message.body)));
                      },
                    );
                  },
                  itemCount: messages.length,
                );
            }
          },
        ),
        floatingActionButton: FutureBuilder(
            future: future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ComposeButton(messages);
              }
            }));
  }
}
