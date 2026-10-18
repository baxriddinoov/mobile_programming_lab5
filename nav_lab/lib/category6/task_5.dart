// Task 6.5 – Custom transitions in go_router (CustomTransitionPage)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Reusable page with a slide-from-right + scale transition.
/// The key (state.pageKey) lets go_router tell pages apart.
CustomTransitionPage<void> buildPage(Widget child, {LocalKey? key}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved =
          CurvedAnimation(parent: animation, curve: Curves.easeInOut);
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(curved),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );
}

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          buildPage(const HomeScreen(), key: state.pageKey),
    ),
    GoRoute(
      path: '/details',
      pageBuilder: (context, state) =>
          buildPage(const DetailsScreen(), key: state.pageKey),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) =>
          buildPage(const SettingsScreen(), key: state.pageKey),
    ),
  ],
);

void main() => runApp(MaterialApp.router(routerConfig: router));

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
              onPressed: () => context.push('/details'),
              child: const Text('Details'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.push('/settings'),
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.pop(),
          child: const Text('pop'),
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
      body: const Center(child: Text('Same transition, reused via buildPage')),
    );
  }
}
