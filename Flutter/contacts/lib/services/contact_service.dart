import '../models/contact.dart';

abstract class ContactService {
  List<Contact> getContacts();
  void addContact(String name, String phone);
  void updateContact(int id, String name, String phone);
  void deleteContact(int id);
}

class ContactServiceImpl implements ContactService {
  List<Contact> _contacts = [];
  int _nextId = 0;

  @override
  List<Contact> getContacts() {
    return _contacts;
  }

  @override
  void addContact(String name, String phone) {
    _contacts.add(Contact(id: _nextId++, name: name, phone: phone));
  }

  @override
  void updateContact(int id, String name, String phone) {
    final index = _contacts.indexWhere((contact) => contact.id == id);
    if (index != -1) {
      _contacts[index] = Contact(id: id, name: name, phone: phone);
    }
  }

  @override
  void deleteContact(int id) {
    _contacts.removeWhere((contact) => contact.id == id);
  }
}
