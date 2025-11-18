// lib/models/product.dart

class Product {
  final String pk;
  final String name;
  final int price;
  final String description;
  final String thumbnail;
  final String category;
  final bool isFeatured;
  final String detailUrl;

  Product({
    required this.pk,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.isFeatured,
    required this.detailUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      pk: json['pk'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String,
      category: json['category'] as String,
      isFeatured: json['is_featured'] as bool,
      detailUrl: json['detail_url'] as String,
    );
  }

  /// Helper to parse the whole response from /api/products/
  static List<Product> listFromResponse(Map<String, dynamic> json) {
    final List<dynamic> rawList = json['products'] ?? [];
    return rawList
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
