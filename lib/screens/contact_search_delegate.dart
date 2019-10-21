import 'package:emailapp/contact_list_builder.dart';
import 'package:emailapp/contact_manager.dart';
import 'package:emailapp/models/Contact.dart';
import 'package:emailapp/provider.dart';
import 'package:flutter/material.dart';

class ContactSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    ContactManager manager = Provider.of(context).fetch(ContactManager);
    if (query.length < 3) {
      return Center(
        child: Text('Type more than 3 characters.'),
      );
    }

    return ContactListBuilder(
        stream: manager.filteredView(query: query),
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
              separatorBuilder: (BuildContext context, int index) => Divider());
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}