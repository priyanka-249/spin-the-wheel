import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(const SpinTheWheelApp());
}

class SpinTheWheelApp extends StatelessWidget {
  const SpinTheWheelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spin the Wheel',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spin the Wheel'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'What should we choose?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // Wheel
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 4,
                    ),
                  ),
                  child: CustomPaint(
                    painter: WheelPainter(),
                  ),
                ),

                // Spin button
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'SPIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                // Pointer
                const Positioned(
                  top: -10,
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 45,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {},
              child: const Text('SPIN THE WHEEL'),
            ),
          ],
        ),
      ),
    );
  }
}

class WheelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()..style = PaintingStyle.fill;

    final options = [
      'Pizza',
      'Burger',
      'Biryani',
      'Noodles',
    ];

    final colors = [
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.purple,
    ];

    const sectionAngle = 3.14159 / 2;

    for (int i = 0; i < options.length; i++) {
      final startAngle = i * sectionAngle - 3.14159 / 2;

      paint.color = colors[i];

      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        startAngle,
        sectionAngle,
        true,
        paint,
      );

      // Text
      final textPainter = TextPainter(
        text: TextSpan(
          text: options[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      final textAngle = startAngle + sectionAngle / 2;

      final textRadius = radius * 0.65;

      final textX =
          center.dx + textRadius * cos(textAngle) - textPainter.width / 2;

      final textY =
          center.dy + textRadius * sin(textAngle) - textPainter.height / 2;

      textPainter.paint(
        canvas,
        Offset(textX, textY),
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}