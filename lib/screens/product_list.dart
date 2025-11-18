// lib/screens/product_list.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:football_shop/models/product.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:football_shop/screens/product_detail.dart';

const String baseUrl = 'http://localhost:8000';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
    final request = context.read<CookieRequest>();
    final url = '$baseUrl/api/products/';

    try {
      // ignore: avoid_print
      print('Fetching products from: $url');

      final response = await request.get(url);

      // If pbp_django_auth already decoded JSON, we expect a Map
      if (response is String) {
        // This happens if the backend sends non-JSON text
        throw Exception('Server returned non-JSON response: $response');
      }

      if (response is! Map<String, dynamic>) {
        throw Exception('Unexpected response type: $response');
      }

      // Handle our custom auth error from Django
      if (response['ok'] == false && response['error'] == 'auth_required') {
        throw Exception('You are not logged in or your session has expired.');
      }

      // Normal success: parse products
      return Product.listFromResponse(response);
    } catch (e) {
      // Catch FormatException etc. from request.get
      throw Exception('Failed to load products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

            if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Failed to load products:\n${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureProducts = _fetchProducts();
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(
              child: Text('No products yet.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(p.thumbnail),
                    onBackgroundImageError: (_, __) {},
                  ),
                  title: Text(p.name),
                  subtitle: Text('${p.category} • Rp${p.price}'),
                  trailing: p.isFeatured
                      ? const Chip(
                          label: Text('Featured'),
                          backgroundColor: Colors.amber,
                        )
                      : null,

                  onTap:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: p),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}