// Task 4.3 – User profile (object as a named-route argument)
import 'package:flutter/material.dart';

class User {
  final String name;
  final int age;
  final String city;
  const User(this.name, this.age, this.city);
}

const users = [
  User('Alice', 24, 'London'),
  User('Bob', 31, 'Berlin'),
  User('Carol', 28, 'Paris'),
  User('David', 35, 'Tashkent'),
];

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const UserListScreen(),
      '/profile': (context) => const ProfileScreen(),
    },
  ));
}

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: ListView(
        children: [
          for (final u in users)
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(u.name),
              onTap: () =>
                  Navigator.pushNamed(context, '/profile', arguments: u),
            ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: ListView(
        children: [
          ListTile(title: const Text('Name'), subtitle: Text(user.name)),
          ListTile(title: const Text('Age'), subtitle: Text('${user.age}')),
          ListTile(title: const Text('City'), subtitle: Text(user.city)),
        ],
      ),
    );
  }
}
