import 'dart:convert';

class Category {
  String? id;
  String imageUrl;
  String name;
  Category(
      {required this.imageUrl,
      required this.name,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        imageUrl: map['imageUrl'] ?? '',
        name: map['name'] ?? '',
        id: map['id'] ?? ' ');
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}