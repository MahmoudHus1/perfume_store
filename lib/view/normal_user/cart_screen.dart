import 'package:flutter/material.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:perfume_store/component/product_cart_widget.dart';
import 'package:perfume_store/core/constant/colors.dart';
import 'package:perfume_store/providers/auth_provider.dart';
import 'package:perfume_store/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const CustomText(
          text: 'Your Cart',
          color: AppColors.primaryColor,
        ),
        backgroundColor: AppColors.secondColor,
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          if (value.getData) {
            value.getCart(Provider.of<AuthProvider>(context, listen: false)
                .loggedUser!
                .id!);
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          return value.cart.isEmpty
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/empty_cart.png"),
                  const CustomText(text: "Cart is empty", fontSize: 30,fontWeight: FontWeight.bold,color: AppColors.secondColor,)
                ],
              )
              : ListView.builder(
                  itemCount: value.cart.length,
                  itemBuilder: (context, index) => ProductCartWidegt(product: value.cart[index]),
                );
        },
      ),
    );
  }
}
