import 'dart:convert';
import 'package:sklepik/models/rating.dart';

List<Product> productsFromJson(String jsonString) {
  final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
      id: parsedJson['id'] as int,
      title: parsedJson['title'] as String,
      price: double.parse(parsedJson['price'].toString()),
      description: parsedJson['description'] as String,
      category: parsedJson['category'] as String,
      image: parsedJson['image'] as String,
      rating: Rating.fromJson(parsedJson['rating']),
    );
  }
}
