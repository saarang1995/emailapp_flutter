import 'package:emailapp/managers/counter_manager.dart';
import 'package:emailapp/observer.dart';
import 'package:emailapp/provider.dart';
import 'package:flutter/cupertino.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterManager manager = Provider.of(context).fetch(CounterManager);
    return Center(
      child: Observer<int>(
        stream: manager.counter$,
        onSuccess: (context, data){
        return Text('Calender: $data');
      },),
    );
  }
}
