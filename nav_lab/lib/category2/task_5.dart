// Task 2.5 – Log out (clear the whole stack)
import 'package:flutter/material.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const profile = '/profile';
}

void main() {
  runApp(MaterialApp(
    initialRoute: AppRoutes.login,
    routes: {
      AppRoutes.login: (context) => const LoginScreen(),
      AppRoutes.home: (context) => const HomeScreen(),
      AppRoutes.profile: (context) => const ProfileScreen(),
    },
    // Fallback (MaterialApp needs one because there is no '/' route).
    onUnknownRoute: (settings) =>
        MaterialPageRoute(builder: (context) => const LoginScreen()),
  ));
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Sign in'),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.home),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Profile'),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Log out'),
          // (route) => false removes every route, so Login is the only one left.
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          ),
        ),
      ),
    );
  }
}
