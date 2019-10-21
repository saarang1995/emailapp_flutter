import 'dart:async';

import 'package:emailapp/models/Contact.dart';
import 'package:emailapp/services/contact_service.dart';

import 'package:rxdart/rxdart.dart';

class ContactManager {
  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  final PublishSubject<List<Contact>> _collectionSubject =
      PublishSubject<List<Contact>>();

  Sink<String> get inFilter => _filterSubject.sink;

  Stream<List<Contact>> get browse$ => _collectionSubject.stream;

  final BehaviorSubject<int> _countSubject = BehaviorSubject<int>();

  Stream<int> get count$ => _countSubject.stream;

  ContactManager() {
    _filterSubject.stream.listen((filter) async {
      List<Contact> contacts = await ContactService.browse(query: filter);
      _collectionSubject.add(contacts);
    });
    _collectionSubject.listen((data) => _countSubject.add(data.length));
  }

  void dispose() {
    _countSubject.close();
    _filterSubject.close();
  }
}
