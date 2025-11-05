import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _showSnack(BuildContext context, String message) {
    // Use ScaffoldMessenger to show a SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Simple, centered three-button layout (icon + text)
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Shop'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              // 1) All Products (BLUE)
              ElevatedButton.icon(
                icon: const Icon(Icons.list),
                label: const Text('All Products'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
                onPressed: () => _showSnack(context, 'You have pressed the All Products button'),
              ),

              // 2) My Products (GREEN)
              ElevatedButton.icon(
                icon: const Icon(Icons.inventory),
                label: const Text('My Products'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
                onPressed: () => _showSnack(context, 'You have pressed the My Products button'),
              ),

              // 3) Create Product (RED)
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Create Product'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
                onPressed: () => _showSnack(context, 'You have pressed the Create Product button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
