import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Observer extends StatelessWidget {
  final Function onError;
  final Function onSuccess;

  const Observer({Key key, this.onError, this.onSuccess}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return onError(context, snapshot.error);
        }       ;
        if (snapshot.hasData) {
          return onSuccess(context, snapshot.data);
        } else{
          return Center( child: CircularProgressIndicator());
        }
      },
    );
  }
}
