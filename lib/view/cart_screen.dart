import 'package:flutter/material.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:perfume_store/core/constant/colors.dart';
import 'package:perfume_store/providers/auth_provider.dart';
import 'package:perfume_store/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ? Center(
                  child: Text(
                    "Cart is empty",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
              : ListView.builder(
                  itemCount: value.cart.length,
                  itemBuilder: (context, index) => Text(value.cart[index].name),
                );
        },
      ),
    );
  }
}
