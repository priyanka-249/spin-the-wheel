
import 'package:flutter/material.dart';

class Experiment02 extends StatelessWidget {
  const Experiment02({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experiment 2: Widgets')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Spin the Wheel',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.casino, size: 40),
                    SizedBox(width: 12),
                    Text('Choose your next meal'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 220,
                    height: 220,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const Icon(
                    Icons.casino,
                    size: 100,
                    color: Colors.white,
                  ),
                  const Positioned(
                    top: 0,
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 48,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                height: 100,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, size: 80),
              ),

              const SizedBox(height: 12),
              const Text('Widgets combined with Row, Column and Stack'),
            ],
          ),
        ),
      ),
    );
  }
}
