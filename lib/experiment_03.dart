
import 'package:flutter/material.dart';

class Experiment03 extends StatelessWidget {
  const Experiment03({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isWideScreen = screenSize.width >= 600;
    final wheelSize = (screenSize.width * 0.65)
        .clamp(180.0, 320.0)
        .toDouble();

    return Scaffold(
      appBar: AppBar(title: const Text('Experiment 3: Responsive UI')),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isWideScreen ? 32 : 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Spin the Wheel',
                style: TextStyle(
                  fontSize: isWideScreen ? 32 : 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isWideScreen
                    ? 'Wide screen layout'
                    : 'Compact screen layout',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Container(
                width: wheelSize,
                height: wheelSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                  border: Border.all(
                    color: Colors.deepPurple.shade200,
                    width: 5,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.casino,
                    color: Colors.white,
                    size: 90,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: isWideScreen ? 280 : double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('SPIN THE WHEEL'),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Screen width: ${screenSize.width.toStringAsFixed(0)} px',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
