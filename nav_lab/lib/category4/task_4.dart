// Task 4.4 – onGenerateRoute (no routes table, typed constructor)
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
    onGenerateRoute: (settings) {
      switch (settings.name) {
        case '/':
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const UserListScreen(),
          );
        case '/profile':
          final args = settings.arguments;
          if (args is User) {
            return MaterialPageRoute(
              settings: settings,
              builder: (context) => ProfileScreen(user: args),
            );
          }
          return MaterialPageRoute(
            builder: (context) =>
                const ErrorScreen(message: '/profile needs a User argument'),
          );
      }
      return null; // falls through to onUnknownRoute
    },
    onUnknownRoute: (settings) => MaterialPageRoute(
      builder: (context) =>
          ErrorScreen(message: 'Route ${settings.name} not found'),
    ),
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
          ListTile(
            leading: const Icon(Icons.warning, color: Colors.orange),
            title: const Text('Open /profile with a wrong argument'),
            onTap: () =>
                Navigator.pushNamed(context, '/profile', arguments: 'oops'),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final User user; // received through the constructor, fully typed
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
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

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text(message)),
    );
  }
}
