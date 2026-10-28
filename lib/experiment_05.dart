
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider state management
class WheelState extends ChangeNotifier {
  final List<String> options = [
    'Pizza',
    'Burger',
    'Biryani',
    'Noodles',
  ];

  String selected = 'Pizza';

  void selectOption(String option) {
    selected = option;
    notifyListeners();
  }
}

class Experiment05 extends StatelessWidget {
  const Experiment05({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WheelState(),
      child: const StateScreen(),
    );
  }
}

class StateScreen extends StatefulWidget {
  const StateScreen({super.key});

  @override
  State<StateScreen> createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  int tapCount = 0;

  @override
  Widget build(BuildContext context) {
    final wheelState = context.watch<WheelState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment 5: State Management'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'setState Example',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Button taps: $tapCount'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    tapCount++;
                  });
                },
                child: const Text('Increase Counter'),
              ),
              const Divider(height: 40),
              const Text(
                'Provider Example',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Selected food: ${wheelState.selected}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: wheelState.options.map((option) {
                  return ElevatedButton(
                    onPressed: () {
                      wheelState.selectOption(option);
                    },
                    child: Text(option),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
