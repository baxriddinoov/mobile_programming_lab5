// Task 3.3 – Contact card (pass the whole object)
import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phone;
  final String email;
  const Contact(this.name, this.phone, this.email);
}

const contacts = [
  Contact('Alice Johnson', '+1 555 0101', 'alice@example.com'),
  Contact('Bob Smith', '+1 555 0102', 'bob@example.com'),
  Contact('Carol White', '+1 555 0103', 'carol@example.com'),
  Contact('David Brown', '+1 555 0104', 'david@example.com'),
  Contact('Eva Green', '+1 555 0105', 'eva@example.com'),
];

void main() => runApp(const MaterialApp(home: ContactListScreen()));

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: ListView(
        children: [
          for (final c in contacts)
            ListTile(
              leading: CircleAvatar(child: Text(c.name[0])),
              title: Text(c.name),
              subtitle: Text(c.phone),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactScreen(contact: c),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  final Contact contact;
  const ContactScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(contact.name)),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          elevation: 6,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Text(contact.name[0],
                      style: const TextStyle(fontSize: 32)),
                ),
                const SizedBox(height: 16),
                Text(contact.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const Divider(height: 32),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(contact.phone),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(contact.email),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
