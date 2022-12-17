import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../models/app_user.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addNewUser(AppUser appUser) async {
    firestore.collection('users').doc(appUser.id).set(appUser.toMap());
  }

  Future<AppUser> getUserFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestore.collection('users').doc(id).get();
    Map<String, dynamic>? data = documentSnapshot.data();
    AppUser appUser = AppUser.fromMap(data!);
    return appUser;
  }

  updateTheUser(AppUser appUser) async {
    print(appUser.imageUrl);
    await firestore.collection('users').doc(appUser.id).update(appUser.toMap());
  }

  Future<String?> addNewCategory(Category category) async {
    try {
      DocumentReference<Map<String, dynamic>> categoryDocument =
          await firestore.collection('categories').add(category.toMap());

      return categoryDocument.id;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool> deleteCategoey(String catId) async {
    try {
      await firestore.collection('categories').doc(catId).delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<List<Category>?> getAllCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> catsSnapshot =
          await firestore.collection('categories').get();
      List<Category> categories = catsSnapshot.docs.map((doc) {
        Category category = Category.fromMap(doc.data());
        category.id = doc.id;
        return category;
      }).toList();
      return categories;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool?> updateCategory(Category category) async {
    try {
      await firestore
          .collection('categories')
          .doc(category.id)
          .update(category.toMap());
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<String?> addNewProduct(Product product) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await firestore
              .collection('categories')
              .doc(product.catId)
              .collection('products')
              .add(product.toMap());
      return documentReference.id;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<List<Product>?> getAllProducts(String catId) async {
    QuerySnapshot<Map<String, dynamic>> productsSnapshot = await firestore
        .collection('categories')
        .doc(catId)
        .collection('products')
        .get();
    try {
      List<Product> products = productsSnapshot.docs.map((doc) {
        Product product = Product.fromMap(doc.data());
        product.id = doc.id;
        return product;
      }).toList();
      return products;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool?> deleteProduct(Product product) async {
        try {
      await firestore.collection('categories').doc(product.catId).collection('products').doc(product.id).delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
  Future<bool?> updateProduct(Product product) async {
        try {
          await firestore.collection('categories').doc(product.catId).collection('products').doc(product.id).update(product.toMap());
      return true;
    } on Exception catch (e) {
      return false;
    }
  }
}
