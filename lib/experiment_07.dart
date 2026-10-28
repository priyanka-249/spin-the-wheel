
import 'package:flutter/material.dart';

class Experiment07 extends StatefulWidget {
  const Experiment07({super.key});

  @override
  State<Experiment07> createState() => _Experiment07State();
}

class _Experiment07State extends State<Experiment07> {
  final _formKey = GlobalKey<FormState>();
  final _optionController = TextEditingController();

  final List<String> options = [
    'Pizza',
    'Burger',
    'Biryani',
  ];

  @override
  void dispose() {
    _optionController.dispose();
    super.dispose();
  }

  void _addOption() {
    if (_formKey.currentState!.validate()) {
      final option = _optionController.text.trim();

      if (options.any(
        (item) => item.toLowerCase() == option.toLowerCase(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('This option already exists!'),
          ),
        );
        return;
      }

      setState(() {
        options.add(option);
        _optionController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Option added successfully!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experiment 7: Form Validation')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _optionController,
                    decoration: const InputDecoration(
                      labelText: 'Enter a food option',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.restaurant),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter an option';
                      }
                      if (value.trim().length < 3) {
                        return 'Enter at least 3 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addOption,
                    child: const Text('Add Option'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Available Options',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(options[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
