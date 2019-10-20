import 'dart:async';

import 'package:emailapp/models/Contact.dart';
import 'package:emailapp/services/contact_service.dart';

class ContactManager {
  Stream<List<Contact>> get contactsListView =>
      Stream.fromFuture(ContactService.browse());

  Stream<List<Contact>> filteredCollection({query}) =>
      Stream.fromFuture(ContactService.browse(query: query));

  final StreamController _contactCounter = StreamController<int>();

  Stream<int> get contactCounter => _contactCounter.stream;

  ContactManager() {
    contactsListView.listen((data) => _contactCounter.add(data.length));
  }
}
