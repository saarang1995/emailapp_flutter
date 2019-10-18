import 'package:emailapp/message_compose.dart';
import 'package:flutter/material.dart';

class ComposeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        String intention = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MessageCompose()));
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(intention),
        ));
      },
    );
  }
}
