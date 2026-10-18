// Task 1.4 – Back to the start (Step 1 -> Step 4, Finish returns to Step 1)
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: StepScreen(step: 1)));

class StepScreen extends StatelessWidget {
  final int step;
  const StepScreen({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final isLast = step == 4;
    return Scaffold(
      appBar: AppBar(title: Text('Step $step')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Step $step of 4', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            if (!isLast)
              ElevatedButton(
                child: const Text('Next'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StepScreen(step: step + 1),
                  ),
                ),
              )
            else
              ElevatedButton(
                child: const Text('Finish'),
                // Pops Steps 4, 3 and 2 in one go.
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
              ),
          ],
        ),
      ),
    );
  }
}
