import 'package:emailapp/overseer.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final OverSeer data;

  Provider({Key key, Widget child, this.data}) : super(key: key, child: child);

  static OverSeer of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).data;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
