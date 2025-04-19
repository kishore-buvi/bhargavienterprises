import 'package:flutter/material.dart';

void main() {
  runApp(const RefundsApp());
}

class RefundsApp extends StatelessWidget {
  const RefundsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RefundsPage(),
    );
  }
}

class RefundsPage extends StatelessWidget {
  const RefundsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F9E9), // light green background
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9F9E9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
            // Handle back action
          },
        ),
        title: const Text(
          'Refunds',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: Colors.grey), // Divider after title
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'No Refunds',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'You have no active or past refunds',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
