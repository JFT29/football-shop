// lib/screens/product_form.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:football_shop/widgets/left_drawer.dart';

const String baseUrl = 'http://localhost:8000';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Fields
  String _name = "";
  String _priceText = "";
  String _description = "";
  String _thumbnail = "";
  String _category = "";
  bool _isFeatured = false;

  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    // get CookieRequest from Provider
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Create Product Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Product Name",
                    labelText: "Product Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (v) => setState(() => _name = v.trim()),
                  validator: (v) {
                    final s = v?.trim() ?? "";
                    if (s.isEmpty) return "Name cannot be empty!";
                    if (s.length < 2) {
                      return "Name must be at least 2 characters.";
                    }
                    return null;
                  },
                ),
              ),

              // === Price ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Price (e.g. 159000)",
                    labelText: "Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  onChanged: (v) => setState(() => _priceText = v.trim()),
                  validator: (v) {
                    final s = v?.trim() ?? "";
                    if (s.isEmpty) return "Price cannot be empty!";
                    final p = int.tryParse(s); // Django expects IntegerField
                    if (p == null) return "Price must be an integer number.";
                    if (p <= 0) return "Price must be greater than 0.";
                    return null;
                  },
                ),
              ),

              // === Thumbnail URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "https://…",
                    labelText: "Thumbnail (URL)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (v) => setState(() => _thumbnail = v.trim()),
                  validator: (v) {
                    final s = v?.trim() ?? "";
                    if (s.isEmpty) return "Thumbnail URL cannot be empty!";
                    final uri = Uri.tryParse(s);
                    final ok = uri != null && uri.hasAbsolutePath;
                    if (!ok ||
                        !(s.startsWith("http://") ||
                            s.startsWith("https://"))) {
                      return "Enter a valid URL (http/https).";
                    }
                    return null;
                  },
                ),
              ),

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "e.g. Boots, Ball, Protection",
                    labelText: "Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (v) => setState(() => _category = v.trim()),
                  validator: (v) {
                    final s = v?.trim() ?? "";
                    if (s.isEmpty) return "Category cannot be empty!";
                    return null;
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Product Description",
                    labelText: "Product Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (v) => setState(() => _description = v.trim()),
                  validator: (v) {
                    final s = v?.trim() ?? "";
                    if (s.isEmpty) return "Description cannot be empty!";
                    if (s.length < 5) {
                      return "Description must be at least 5 characters.";
                    }
                    return null;
                  },
                ),
              ),

              // === Featured ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Featured"),
                  value: _isFeatured,
                  onChanged: (b) => setState(() => _isFeatured = b),
                ),
              ),

              const SizedBox(height: 8),

              // === Save Button ===
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: _isSubmitting
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) return;

                          setState(() {
                            _isSubmitting = true;
                          });

                          try {
                            final priceInt = int.parse(_priceText);

                            final url = '$baseUrl/api/products/create/';

                            final response = await request.post(
                              url,
                              {
                                'name': _name,
                                'price': priceInt.toString(),
                                'description': _description,
                                'thumbnail': _thumbnail,
                                'category': _category,
                                'is_featured': _isFeatured.toString(),
                              },
                            );

                            if (!mounted) return;

                            if (response['ok'] == true) {
                              // Success – product created in Django
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Product created successfully.'),
                                  ),
                                );

                              // Go back to previous page (e.g. menu or list)
                              Navigator.pop(context);
                            } else {
                              final err = response['errors'] ??
                                  response['error'] ??
                                  'Failed to create product.';
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Create Failed'),
                                  content: Text(err.toString()),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } catch (e) {
                            if (!mounted) return;
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: Text(
                                  'Unexpected error while creating product: $e',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          } finally {
                            if (mounted) {
                              setState(() {
                                _isSubmitting = false;
                              });
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
