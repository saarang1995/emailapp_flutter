import 'package:emailapp/managers/counter_manager.dart';
import 'package:emailapp/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FabButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterManager manager = Provider.of(context).fetch(CounterManager);
    return FloatingActionButton(
      onPressed: manager.increment,
    );
  }
}
