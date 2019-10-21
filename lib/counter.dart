import 'package:emailapp/managers/counter_manager.dart';
import 'package:emailapp/provider.dart';
import 'package:flutter/cupertino.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterManager manager = Provider.of(context).fetch(CounterManager);
    return Center(
      child: StreamBuilder<int>(
        initialData: 0,
        stream: manager.counter$,
        builder: (context, snapshot){
        return Text('Calender: ${snapshot.data}');
      },),
    );
  }
}
