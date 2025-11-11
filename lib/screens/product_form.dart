import 'package:flutter/material.dart';
import 'package:football_shop/widgets/left_drawer.dart';

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

  @override
  Widget build(BuildContext context) {
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
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (v) => setState(() => _priceText = v.trim()),
                  validator: (v) {
                    final s = v?.trim() ?? "";
                    if (s.isEmpty) return "Price cannot be empty!";
                    final p = double.tryParse(s);
                    if (p == null) return "Price must be a number.";
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
                    final ok = Uri.tryParse(s)?.hasAbsolutePath ?? false;
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

              // === Save Button ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog<void>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title:
                                const Text('Product saved successfully!'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text('Name: $_name'),
                                  Text('Price: $_priceText'),
                                  Text('Thumbnail: $_thumbnail'),
                                  Text('Category: $_category'),
                                  Text('Description: $_description'),
                                  Text('Featured: ${_isFeatured ? "Yes" : "No"}'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _formKey.currentState!.reset();
                                  setState(() {
                                    _name = "";
                                    _priceText = "";
                                    _description = "";
                                    _thumbnail = "";
                                    _category = "";
                                    _isFeatured = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
