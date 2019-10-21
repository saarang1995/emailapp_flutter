import 'dart:async';

import 'package:emailapp/models/Contact.dart';
import 'package:emailapp/services/contact_service.dart';

import 'package:rxdart/rxdart.dart';

class ContactManager {
  Stream<List<Contact>> get contactsListView =>
      Stream.fromFuture(ContactService.browse());

  Stream<List<Contact>> filteredView({query}) =>
      Stream.fromFuture(ContactService.browse(query: query));

  final BehaviorSubject<int> _contactCounter = BehaviorSubject<int>();

  Stream<int> get contactCounter => _contactCounter.stream;

  ContactManager() {
    contactsListView.listen((data) => _contactCounter.add(data.length));
  }
}
