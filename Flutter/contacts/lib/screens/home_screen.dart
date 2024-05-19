import 'package:flutter/material.dart';
import '../services/contact_service.dart';
import '../models/contact.dart';

class HomeScreen extends StatefulWidget {
  final ContactService contactService;

  HomeScreen({required this.contactService});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ContactService contactService;
  late List<Contact> _contacts;

  @override
  void initState() {
    super.initState();
    contactService = widget.contactService;
    _contacts = contactService.getContacts();
  }

  void _refreshContactList() {
    setState(() {
      _contacts = contactService.getContacts();
    });
  }

  Future<void> _showContactDialog({Contact? contact}) async {
    final _nameController = TextEditingController(text: contact?.name);
    final _phoneController = TextEditingController(text: contact?.phone);
    final isEditing = contact != null;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Contact' : 'Add Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(isEditing ? 'Save' : 'Add'),
              onPressed: () {
                final name = _nameController.text;
                final phone = _phoneController.text;
                if (name.isNotEmpty && phone.isNotEmpty) {
                  if (isEditing) {
                    contactService.updateContact(contact.id, name, phone);
                  } else {
                    contactService.addContact(name, phone);
                  }
                  _refreshContactList();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                contactService.deleteContact(contact.id);
                _refreshContactList();
              },
            ),
            onTap: () {
              _showContactDialog(contact: contact);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showContactDialog();
        },
      ),
    );
  }
}
