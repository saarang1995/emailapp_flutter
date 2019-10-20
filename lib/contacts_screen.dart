import 'package:emailapp/contact_list_builder.dart';
import 'package:emailapp/contact_manager.dart';
import 'package:emailapp/contact_search_delegate.dart';
import 'package:emailapp/models/Contact.dart';
import 'package:emailapp/navigation_drawer.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  ContactManager contactManager = ContactManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
          actions: <Widget>[
            Chip(
                backgroundColor: Colors.red,
                label: StreamBuilder<int>(
                    stream: contactManager.contactCounter,
                    builder: (BuildContext context, snapshot) {
                      return Text(
                        (snapshot.data ?? 0).toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    })),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate:
                        ContactSearchDelegate(manager: this.contactManager));
              },
            ),
            Padding(padding: EdgeInsets.only(right: 16)),
          ],
        ),
        drawer: NavigationDrawer(),
        body: ContactListBuilder(
            stream: contactManager.contactsListView,
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
            }));
  }
}
