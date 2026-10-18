// Task 2.3 – Page not found (onUnknownRoute)
import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/';
  static const settings = '/settings';
}

void main() {
  runApp(MaterialApp(
    initialRoute: AppRoutes.home,
    routes: {
      AppRoutes.home: (context) => const HomeScreen(),
      AppRoutes.settings: (context) => const SettingsScreen(),
    },
    onUnknownRoute: (settings) => MaterialPageRoute(
      builder: (context) => NotFoundScreen(routeName: settings.name),
    ),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('Settings'),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              child: const Text('Broken link'),
              onPressed: () => Navigator.pushNamed(context, '/does-not-exist'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings')),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  final String? routeName;
  const NotFoundScreen({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 12),
            Text('Page "$routeName" not found',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            ElevatedButton(
              child: const Text('Back'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
