import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../app_router/app_router.dart';
import '../data_repositories/firestore_helper.dart';
import '../data_repositories/storage_helper.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../view/admin/edit_category.dart';
import '../view/admin/edit_product.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider(){
    getAllCategories();
  }

  List<Product> menProducts = [];
  List<Product> womenProducts = [];
  bool getData = false;

  String? requiredValidation(String? content) {
    if (content == null || content.isEmpty) {
      return "Required field";
    }
  }

  File? imageFile;
  File? ingredientFile;
  TextEditingController catNameController = TextEditingController();
  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();
  pickImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
  pickIngredientImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      ingredientFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  addNewCategory() async {
    if (imageFile != null) {
      if (categoryFormKey.currentState!.validate()) {
        AppRouter.appRouter.showLoadingDialoug();
        String imageUrl = await StorageHelper.storageHelper
            .uploadNewImage("cats_images", imageFile!);
        Category category =
            Category(imageUrl: imageUrl, name: catNameController.text);

        String? id =
            await FirestoreHelper.firestoreHelper.addNewCategory(category);

        AppRouter.appRouter.hideDialoug();
        if (id != null) {
          category.id = id;
          allCategories!.add(category);
          notifyListeners();
          catNameController.clear();
          imageFile = null;
          notifyListeners();
          AppRouter.appRouter
              .showCustomDialoug('Success', 'Your category has been added');
        }
      }
    } else {
      AppRouter.appRouter
          .showCustomDialoug('Error', 'You have to pick image first');
    }
  }

  List<Category>? allCategories;
  List<Product>? allProducts;
  getAllCategories() async {
    allCategories = await FirestoreHelper.firestoreHelper.getAllCategories();
    await getAllProducts("GvBPyFxGsgcRBNJFYBTT");
    notifyListeners();
  }

  deleteCategory(Category category) async {
    AppRouter.appRouter.showLoadingDialoug();
    bool deleteSuccess =
        await FirestoreHelper.firestoreHelper.deleteCategoey(category.id!);
    if (deleteSuccess) {
      allCategories!.remove(category);
      notifyListeners();
    }
    AppRouter.appRouter.hideDialoug();
  }

  goToEditCategoryPage(Category category) {
    catNameController.text = category.name;
    AppRouter.appRouter.goToWidget(EditCategory(category));
  }

  goToEditProductPage(Product product) {
    productDescriptionController.text = product.description;
    productNameController.text = product.name;
    productPriceController.text = product.price;
    AppRouter.appRouter.goToWidget(EditProduct(product));
  }

  updateCategory(Category category) async {
    AppRouter.appRouter.showLoadingDialoug();
    if (imageFile != null) {
      String imageUrl = await StorageHelper.storageHelper
          .uploadNewImage("cats_images", imageFile!);
      category.imageUrl = imageUrl;
    }
    Category newCategory = Category(
      id: category.id,
      imageUrl: category.imageUrl,
      name: catNameController.text.isEmpty
          ? category.name
          : catNameController.text,
    );

    bool? isUpdated =
        await FirestoreHelper.firestoreHelper.updateCategory(newCategory);

    if (isUpdated != null && isUpdated) {
      int index = allCategories!.indexOf(category);
      allCategories![index] = newCategory;
      imageFile = null;
      catNameController.clear();
      notifyListeners();
      AppRouter.appRouter.hideDialoug();
      AppRouter.appRouter.hideDialoug();
    }
  }

  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  GlobalKey<FormState> productKey = GlobalKey();
  addNewProduct(String catId) async {
    if (imageFile != null && ingredientFile!=null) {
      if (productKey.currentState!.validate()) {
        AppRouter.appRouter.showLoadingDialoug();
        String imageUrl = await StorageHelper.storageHelper
            .uploadNewImage("products_images", imageFile!);
        String ingredientImage = await StorageHelper.storageHelper
            .uploadNewImage("products_images", ingredientFile!);
        Product product = Product(
            imageUrl: imageUrl,
            ingredientImage:ingredientImage,
            name: productNameController.text,
            description: productDescriptionController.text,
            price: productPriceController.text,
            catId: catId);

        String? id =
            await FirestoreHelper.firestoreHelper.addNewProduct(product);

        AppRouter.appRouter.hideDialoug();
        if (id != null) {
          product.id = id;
          allProducts?.add(product);
          notifyListeners();
          productNameController.clear();
          productDescriptionController.clear();
          productPriceController.clear();
          imageFile = null;
          ingredientFile=null;
          notifyListeners();
          AppRouter.appRouter
              .showCustomDialoug('Success', 'Your Product has been added');
          print(allProducts![0].price);
        }
      }
    } else {
      AppRouter.appRouter
          .showCustomDialoug('Error', 'You have to pick image first');
    }
  }

  getMenAndWomenProducts() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('categories').get();
    for (var doc in querySnapshot.docs) {
      if(((doc.data() as Map)['name'] as String).contains('Women')){
        womenProducts = [];
        final QuerySnapshot productData = await FirebaseFirestore.instance.collection('categories/${doc.id}/products').get();
        for (int i = 0; i < productData.docChanges.length; i++){
           womenProducts.add(Product.fromMap(productData.docs[i].data() as Map<String, dynamic>));
        }
      }
      else if(((doc.data() as Map)['name'] as String).contains('Men')) {
        menProducts = [];
         final QuerySnapshot productData = await FirebaseFirestore.instance.collection('categories/${doc.id}/products').get();
        for (int i = 0; i < productData.docChanges.length; i++){
           menProducts.add(Product.fromMap(productData.docs[i].data() as Map<String, dynamic>));
        }
      }
    }
    getData = true;
    notifyListeners();
  }

  getAllProducts(String catId) async {
   
    allProducts = null;
    notifyListeners();
    allProducts = await FirestoreHelper.firestoreHelper.getAllProducts(catId);

    notifyListeners();
  }

  deleteProduct(Product product) async {
    AppRouter.appRouter.showLoadingDialoug();
    bool? deleteSuccess =
        await FirestoreHelper.firestoreHelper.deleteProduct(product);
    if (deleteSuccess ?? false) {
      allProducts!.remove(product);
      notifyListeners();
    }
    AppRouter.appRouter.hideDialoug();
  }

  updateProduct(Product product) async {
    AppRouter.appRouter.showLoadingDialoug();
    if (imageFile != null) {
      String imageUrl = await StorageHelper.storageHelper
          .uploadNewImage("products_images", imageFile!);
      String ingredientImage = await StorageHelper.storageHelper
          .uploadNewImage("products_images", ingredientFile!);
      product.imageUrl = imageUrl;
      product.ingredientImage = ingredientImage;
    }
    Product newProduct = Product(
        id: product.id,
        imageUrl: product.imageUrl,
        ingredientImage :product.ingredientImage,
        name: productNameController.text.isEmpty
            ? product.name
            : productNameController.text,
        catId: product.catId,
        description: productDescriptionController.text.isEmpty
            ? product.description
            : productDescriptionController.text,
        price: productPriceController.text.isEmpty
            ? product.price
            : productPriceController.text);

    bool? isUpdated =
        await FirestoreHelper.firestoreHelper.updateProduct(newProduct);

    if (isUpdated != null && isUpdated) {
      int index = allProducts!.indexOf(product);
      allProducts![index] = product;
      imageFile = null;
      ingredientFile=null;
      productNameController.clear();
      productDescriptionController.clear();
      productPriceController.clear();
      notifyListeners();
      AppRouter.appRouter.hideDialoug();
      AppRouter.appRouter.hideDialoug();
    }
  }

  List<Product>? allProductsForAllCats;

  getAllProductsForAllCats() {
    getAllProducts("GvBPyFxGsgcRBNJFYBTT");
    allProductsForAllCats = allProducts;
  }
}
