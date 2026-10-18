// Task 4.5 – Result from a named route
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    // onGenerateRoute (not the routes table) so /rate is a Route<int>.
    // The routes table always builds MaterialPageRoute<dynamic>, and
    // pushNamed<int> would then fail with a type error.
    onGenerateRoute: (settings) {
      switch (settings.name) {
        case '/':
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (context) => const HomeScreen(),
          );
        case '/rate':
          return MaterialPageRoute<int>(
            settings: settings,
            builder: (context) => const RateScreen(),
          );
      }
      return null;
    },
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _movie = 'Inception';
  int? _rating;

  Future<void> _rate() async {
    final rating =
        await Navigator.pushNamed<int>(context, '/rate', arguments: _movie);
    if (!mounted) return;
    // Back arrow -> rating is null -> keep the previous rating.
    if (rating != null) setState(() => _rating = rating);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _rating == null ? '$_movie: not rated' : '$_movie: $_rating/5',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _rate, child: const Text('Rate movie')),
          ],
        ),
      ),
    );
  }
}

class RateScreen extends StatelessWidget {
  const RateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text('Rate "$title"')),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 1; i <= 5; i++)
              IconButton(
                iconSize: 40,
                icon: const Icon(Icons.star, color: Colors.amber),
                tooltip: '$i',
                onPressed: () => Navigator.pop(context, i),
              ),
          ],
        ),
      ),
    );
  }
}
