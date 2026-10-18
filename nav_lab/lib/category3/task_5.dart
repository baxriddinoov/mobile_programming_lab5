// Task 3.5 – Edit a counter (Save returns a value, back arrow returns null)
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CounterScreen()));

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _value = 0;

  Future<void> _edit() async {
    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(builder: (context) => EditorScreen(initial: _value)),
    );
    if (!mounted) return;
    // result is null when the user leaves with the back arrow: keep the old value.
    if (result != null) {
      setState(() => _value = result);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not saved – value unchanged')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$_value', style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _edit, child: const Text('Edit')),
          ],
        ),
      ),
    );
  }
}

class EditorScreen extends StatefulWidget {
  final int initial;
  const EditorScreen({super.key, required this.initial});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late int _value = widget.initial;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editor')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton.filled(
                  icon: const Icon(Icons.remove),
                  onPressed: () => setState(() => _value--),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text('$_value', style: const TextStyle(fontSize: 48)),
                ),
                IconButton.filled(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => _value++),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, _value),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
