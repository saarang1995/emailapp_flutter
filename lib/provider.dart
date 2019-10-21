import 'package:emailapp/contact_manager.dart';
import 'package:flutter/material.dart';

class Provider<T> extends InheritedWidget {
  final T data;

  Provider({Key key, Widget child, this.data}) : super(key: key, child: child);

  static ContactManager of<T>(BuildContext context) {
    final type = _typeOf<Provider<T>>();
    return (context.ancestorWidgetOfExactType(type) as Provider).data;
  }

  static _typeOf<T>() => T;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}