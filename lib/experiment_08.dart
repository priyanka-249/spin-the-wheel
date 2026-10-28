
import 'dart:math' as math;
import 'package:flutter/material.dart';

class Experiment08 extends StatefulWidget {
  const Experiment08({super.key});

  @override
  State<Experiment08> createState() => _Experiment08State();
}

class _Experiment08State extends State<Experiment08>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;
  bool _isSpinning = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _rotation = Tween<double>(
      begin: 0,
      end: 2 * math.pi * 5,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isSpinning = false;
        });
      }
    });
  }

  void _spinWheel() {
    if (_isSpinning) return;

    setState(() {
      _isSpinning = true;
    });

    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experiment 8: Animation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _rotation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotation.value,
                  child: child,
                );
              },
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.deepPurple,
                    width: 5,
                  ),
                  gradient: const SweepGradient(
                    colors: [
                      Colors.deepPurple,
                      Colors.purpleAccent,
                      Colors.orangeAccent,
                      Colors.deepPurple,
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.casino,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isSpinning ? null : _spinWheel,
              child: Text(
                _isSpinning ? 'SPINNING...' : 'SPIN THE WHEEL',
              ),
            ),
            const SizedBox(height: 12),
            const Text('Animation: Rotation with ease-out curve'),
          ],
        ),
      ),
    );
  }
}
