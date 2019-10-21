import 'package:emailapp/app.dart';
import 'package:emailapp/contact_manager.dart';
import 'package:emailapp/overseer.dart';
import 'package:emailapp/provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(EmailApp());

class EmailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<OverSeer>(
      data: OverSeer(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.red),
        home: App(),
      ),
    );
  }
}
