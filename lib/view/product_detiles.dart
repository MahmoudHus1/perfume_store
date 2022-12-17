// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:perfume_store/component/custom_button.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:perfume_store/core/constant/colors.dart';

import 'package:perfume_store/models/product.dart';

class ProductDetiles extends StatelessWidget {
  Product product;
  ProductDetiles({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: product.name,
            color: AppColors.primaryColor,
          ),
          backgroundColor: AppColors.secondColor,
        ),
        body: Container(
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: SizedBox(
                                  height: 250,
                                  width: 150,
                                  child:
                                      Image.network(product.ingredientImage, fit: BoxFit.cover,))),
                          Expanded(
                              child: SizedBox(
                                  height: 250,
                                  width: 150,
                                  child: Image.network(product.imageUrl, fit: BoxFit.cover,)))
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const CustomText(
                        text: "Details",
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondColor,
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 365,
                            child: CustomText(text: product.description)),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CustomText(
                              text: "PRICE",
                              color: AppColors.secondColor.withOpacity(0.6),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          CustomText(
                            text: "\$${product.price}",
                            color: AppColors.primaryColor,
                            fontSize: 20,
                          )
                        ],
                      ),
                      CustomButton(text: "Add to cart", function: () {})
                    ],
                  ),
                )
              ],
            )));
  }
}
