// Task 4.2 – Send a number (plain int as a named-route argument)
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeScreen(),
      '/square': (context) => const SquareScreen(),
    },
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final n in [1, 2, 3])
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/square', arguments: n),
                  child: Text('$n'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SquareScreen extends StatelessWidget {
  const SquareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final n = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(title: Text('Square of $n')),
      body: Center(
        child: Text('$n² = ${n * n}', style: const TextStyle(fontSize: 40)),
      ),
    );
  }
}
