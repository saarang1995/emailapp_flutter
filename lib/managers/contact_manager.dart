import 'dart:async';

import 'package:emailapp/models/Contact.dart';
import 'package:emailapp/services/contact_service.dart';

import 'package:rxdart/rxdart.dart';

class ContactManager {
  // Stream<List<Contact>> get contactsListView =>
  //     Stream.fromFuture(ContactService.browse());

  Stream<List<Contact>> browse$({String query}) =>
      Stream.fromFuture(ContactService.browse(query: query));

  final BehaviorSubject<int> _contactCounter = BehaviorSubject<int>();

  Stream<int> get count$ => _contactCounter.stream;

  ContactManager() {
    browse$().listen((data) => _contactCounter.add(data.length));
  }
}
