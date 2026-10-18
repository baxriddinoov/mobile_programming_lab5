
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ScreenA()));

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen A'), backgroundColor: Colors.red),
      body: Center(
        child: ElevatedButton(
          child: const Text('Next'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScreenB()),
          ),
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen B'), backgroundColor: Colors.green),
      body: Center(
        child: ElevatedButton(
          child: const Text('Next'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScreenC()),
          ),
        ),
      ),
    );
  }
}

class ScreenC extends StatelessWidget {
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen C'), backgroundColor: Colors.blue),
      body: Center(
        child: ElevatedButton(
          child: const Text('Back'),
          onPressed: () => Navigator.pop(context), // returns to B
        ),
      ),
    );
  }
}

// System back button: C -> B, B -> A, A -> closes the app (stack is empty).
