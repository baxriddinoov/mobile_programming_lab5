// Task 5.3 – Slide from the bottom (with CurvedAnimation, 500 ms)
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

Route<void> slideRoute(Widget page, Offset begin, Duration duration,
    {Curve curve = Curves.linear}) {
  return PageRouteBuilder(
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: curve);
      return SlideTransition(
        position: Tween<Offset>(begin: begin, end: Offset.zero).animate(curved),
        child: child,
      );
    },
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
              child: const Text('Open with slide'),
              onPressed: () => Navigator.push(
                context,
                slideRoute(const DetailsScreen(), const Offset(1, 0),
                    const Duration(milliseconds: 400)),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              child: const Text('Open as a sheet'),
              onPressed: () => Navigator.push(
                context,
                slideRoute(
                  const DetailsScreen(),
                  const Offset(0, 1), // starts below the screen
                  const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                ),
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
      body: const Center(child: Text('Hello from the details screen')),
    );
  }
}
