// Task 3.4 – Pick a colour (return a result with pop)
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ColorScreen()));

class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  Color _color = Colors.grey;

  Future<void> _chooseColor() async {
    final c = await Navigator.push<Color>(
      context,
      MaterialPageRoute(builder: (context) => const ColorPickerScreen()),
    );
    if (!mounted) return;
    if (c != null) setState(() => _color = c); // null = user pressed back
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current colour')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 150, height: 150, color: _color),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _chooseColor,
              child: const Text('Choose colour'),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPickerScreen extends StatelessWidget {
  const ColorPickerScreen({super.key});

  static const _options = {
    'Red': Colors.red,
    'Green': Colors.green,
    'Blue': Colors.blue,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick a colour')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final entry in _options.entries)
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: entry.value,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(160, 48),
                  ),
                  onPressed: () => Navigator.pop(context, entry.value),
                  child: Text(entry.key),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
