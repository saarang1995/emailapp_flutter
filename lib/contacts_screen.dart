import 'package:emailapp/contact_manager.dart';
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
                label: StreamBuilder(
                    stream: contactManager.contactCounter,
                    builder: (BuildContext context, snapshot) {
                      return Text(
                        (snapshot.data ?? 0).toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    })),
            Padding(padding: EdgeInsets.only(right: 16)),
          ],
        ),
        drawer: NavigationDrawer(),
        body: StreamBuilder<List<String>>(
            stream: contactManager.contactsListNow,
            builder: (BuildContext context, snapshot) {
              List<String> contacts = snapshot.data;
              if (contacts == null)
                return Center(
                  child: Text("No Data"),
                );

              return ListView.separated(
                  itemCount: contacts.length,
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      title: Text(contacts[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider());
            }));
  }
}
