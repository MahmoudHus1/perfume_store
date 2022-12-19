// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:perfume_store/core/constant/colors.dart';

import 'package:perfume_store/models/product.dart';
import 'package:perfume_store/providers/auth_provider.dart';
import 'package:perfume_store/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductCartWidegt extends StatelessWidget {
  Product product;
  ProductCartWidegt({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.secondColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.secondColor, width: 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(product.imageUrl),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomText(
                  text: product.name,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondColor),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                    color: AppColors.secondColor,
                    borderRadius: BorderRadius.circular(15)),
                child: CustomText(
                  text: "${product.price} \$",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    Provider.of<CartProvider>(context, listen: false).delete(
                        Provider.of<AuthProvider>(context, listen: false)
                            .loggedUser!
                            .id!,
                        product);
                  },
                  child: const Icon(
                    Icons.delete,
                    size: 40,
                    color: Colors.red,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
