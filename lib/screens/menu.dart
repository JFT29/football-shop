// lib/screens/menu.dart

import 'package:flutter/material.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:football_shop/screens/product_form.dart';
import 'package:football_shop/screens/product_list.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Shop'),
      ),
      drawer: const LeftDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              // 1) All Products → opens ProductListPage
              ElevatedButton.icon(
                icon: const Icon(Icons.list),
                label: const Text('All Products'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                ),
                onPressed: () {
                  _showSnack(
                    context,
                    'You have pressed the All Products button',
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProductListPage(),
                    ),
                  );
                },
              ),

              // 2) My Products (for now same as All Products; later we filter)
              ElevatedButton.icon(
                icon: const Icon(Icons.inventory),
                label: const Text('My Products'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                ),
                onPressed: () {
                  _showSnack(
                    context,
                    'You have pressed the My Products button',
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProductListPage(),
                    ),
                  );
                },
              ),

              // 3) Create Product — go to ProductFormPage
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Create Product'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                ),
                onPressed: () {
                  _showSnack(
                    context,
                    'You have pressed the Create Product button',
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProductFormPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
