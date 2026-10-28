
import 'package:flutter/material.dart';

void main() {
  runApp(const Experiment06App());
}

class Experiment06App extends StatelessWidget {
  const Experiment06App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        scaffoldBackgroundColor: const Color(0xFFF9F5FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 14,
            ),
          ),
        ),
      ),
      home: const CustomWidgetsScreen(),
    );
  }
}

// Reusable custom widget
class WheelOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const WheelOptionCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

class CustomWidgetsScreen extends StatelessWidget {
  const CustomWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experiment 6: Themes')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Choose your favourite',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const WheelOptionCard(
            title: 'Pizza',
            icon: Icons.local_pizza,
          ),
          const WheelOptionCard(
            title: 'Burger',
            icon: Icons.lunch_dining,
          ),
          const WheelOptionCard(
            title: 'Biryani',
            icon: Icons.rice_bowl,
          ),
          const WheelOptionCard(
            title: 'Noodles',
            icon: Icons.ramen_dining,
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Custom theme applied successfully!'),
                  ),
                );
              },
              child: const Text('Test Theme'),
            ),
          ),
        ],
      ),
    );
  }
}
