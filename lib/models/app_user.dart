import 'dart:convert';

class AppUser {
  String email;
  String? id;
  String? imageUrl;
  String userName;
  String phoneNumber;
  bool isAdmin;
  AppUser(
      {required this.email,
      required this.userName,
      required this.phoneNumber,
      this.id,
      this.imageUrl = "https://firebasestorage.googleapis.com/v0/b/dogwood-baton-371407.appspot.com/o/user_image%2Favatar-370-456322.webp?alt=media&token=3578907b-21e0-4bcb-9e8f-dfe4e982691d",
      this.isAdmin = false
      });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'isAdmin' : isAdmin
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      email: map['email'] ?? '',
      userName: map['userName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      imageUrl: map['imageUrl'],
      isAdmin:  map['isAdmin'] ?? false
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));
}