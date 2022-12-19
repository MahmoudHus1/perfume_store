import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perfume_store/models/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> cart = [];
  bool isLoading = false;
  bool getData = true;

  Future<void> addToCart(Product product, String uid, String pid) async {
    isLoading = true;
    cart.add(product);
    notifyListeners();

    await FirebaseFirestore.instance.collection('users/$uid/cart').doc(pid).set(
          product.toMap(),
        );
    isLoading = false;
    notifyListeners();
  }

  Future<void> getCart(String uid) async {
    cart = [];

    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users/$uid/cart').get();

    for (var doc in querySnapshot.docs) {
      Product product = Product.fromMap(doc.data() as Map<String, dynamic>);
      product.id = doc.id;

      cart.add(product);
    }

    getData = false;
    notifyListeners();
  }

  Future<bool> delete(String uid, Product product) async {
    try {
       FirebaseFirestore.instance
          .collection('users/$uid/cart')
          .doc(product.id).delete();
          cart.remove(product);
          notifyListeners();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
}
