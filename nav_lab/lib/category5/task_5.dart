// Task 5.5 – Reusable FadeRoute + app-wide transition via ThemeData
import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    // Part 2: every MaterialPageRoute in the app now uses the iOS-style
    // slide, also on Android – no custom route needed.
    theme: ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    ),
    home: const HomeScreen(),
  ));
}

// Part 1: a reusable fade route.
class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute(this.page)
      : super(
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
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
              child: const Text('FadeRoute'),
              onPressed: () =>
                  Navigator.push(context, FadeRoute(const DetailsScreen())),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              child: const Text('MaterialPageRoute (theme transition)'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailsScreen()),
              ),
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
      body: const Center(child: Text('Compare the two transitions')),
    );
  }
}
