import 'dart:async';

import 'package:emailapp/models/Contact.dart';
import 'package:emailapp/services/contact_service.dart';

import 'package:rxdart/rxdart.dart';

class ContactManager {
  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  final PublishSubject<List<Contact>> _collectionSubject =
      PublishSubject<List<Contact>>();
  final PublishSubject<int> _countSubject = PublishSubject<int>();

  Sink<String> get inFilter => _filterSubject.sink;

  Stream<List<Contact>> get browse$ => _collectionSubject.stream;

  Stream<int> get count$ => _countSubject.stream;

  ContactManager() {
    _filterSubject.stream
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((filter) async* {
          yield await ContactService.browse(query: filter);
          }).
        listen((contacts) async {
          _collectionSubject.add(contacts);
        });
    _collectionSubject.listen((data) => _countSubject.add(data.length));
  }

  void dispose() {
    _countSubject.close();
    _filterSubject.close();
  }
}
