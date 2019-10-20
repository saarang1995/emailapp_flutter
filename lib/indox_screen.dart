import 'package:emailapp/message_list.dart';
import 'package:emailapp/navigation_drawer.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {},
            )
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Important"),
              Tab(text: "Others"),
            ],
          ),
        ),
        drawer: NavigationDrawer(),
        body: TabBarView(
          children: <Widget>[
            MessageList(status: "important"),
            MessageList(status: "others")
          ],
        ),
      ),
      length: 2,
    );
  }
}
