
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Experiment09 extends StatefulWidget {
  const Experiment09({super.key});

  @override
  State<Experiment09> createState() => _Experiment09State();
}

class _Experiment09State extends State<Experiment09> {
  String activity = '';
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchActivity() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      activity = '';
    });

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos/1'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          activity = data['title'] as String? ?? 'No title found';
        });
      } else {
        setState(() {
          errorMessage = 'Server error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Could not fetch data. Check your connection.';
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experiment 9: REST API')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cloud_download_outlined,
                size: 72,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20),
              const Text(
                'API Response',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (isLoading)
                const CircularProgressIndicator()
              else if (errorMessage != null)
                Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                )
              else
                Text(
                  activity.isEmpty
                      ? 'Tap below to fetch data from the API.'
                      : activity,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : fetchActivity,
                child: const Text('Fetch Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
