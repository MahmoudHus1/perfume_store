import 'dart:convert';

class Product {
  String? id;
  String catId;
  String name;
  String description;
  String imageUrl;
  String ingredientImage;
  String price;
  Product({
    this.id,
    required this.catId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.ingredientImage,
    required this.price
  });

  Map<String, dynamic> toMap() {
    return {
      'catId': catId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'ingredientImage': ingredientImage,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      catId: map['catId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      ingredientImage: map['ingredientImage'] ?? '',
      price: map['price'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}