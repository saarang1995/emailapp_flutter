import 'package:flutter/material.dart';

class MessageDetail extends StatelessWidget {
  final String message, title;

  MessageDetail(this.title, this.message);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
