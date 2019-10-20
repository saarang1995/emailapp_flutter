import 'package:emailapp/navigation_drawer.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Celendar'),
        ),
        drawer: NavigationDrawer(),
        body: Center(
          child: Text('Celendar'),
        ));
  }
}
