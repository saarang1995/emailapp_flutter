import 'package:emailapp/contact_counter.dart';
import 'package:emailapp/contact_list_builder.dart';
import 'package:emailapp/contact_manager.dart';
import 'package:emailapp/screens/contact_search_delegate.dart';
import 'package:emailapp/models/Contact.dart';
import 'package:emailapp/navigation_drawer.dart';
import 'package:emailapp/provider.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactManager manager = Provider.of(context).fetch(ContactManager);
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
          actions: <Widget>[
            ContactCounter(),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: ContactSearchDelegate());
              },
            ),
            Padding(padding: EdgeInsets.only(right: 16)),
          ],
        ),
        drawer: NavigationDrawer(),
        body: ContactListBuilder(
          stream: manager.contactsListView,
          builder: (context, contacts) {
            return ListView.separated(
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, index) {
                  Contact _contact = contacts[index];
                  return ListTile(
                    title: Text(_contact.name),
                    subtitle: Text(_contact.email),
                    leading: CircleAvatar(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider());
          },
        ));
  }
}
