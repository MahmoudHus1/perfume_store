import 'package:flutter/material.dart';
import 'package:perfume_store/app_router/app_router.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:perfume_store/core/constant/colors.dart';
import 'package:perfume_store/providers/auth_provider.dart';
import 'package:perfume_store/view/admin/add_product.dart';
import 'package:provider/provider.dart';

import '../component/product_widget.dart';
import '../providers/admin_provider.dart';

// ignore: must_be_immutable
class AllProducts extends StatelessWidget {
  String? catId;

  AllProducts({required this.catId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Provider.of<AuthProvider>(context).loggedUser!.isAdmin ?
          IconButton(
              onPressed: () {
                AppRouter.appRouter.goToWidget(AddNewProduct(catId!));
              },
              icon: const Icon(
                Icons.add,
                color: AppColors.primaryColor,
              )):
              const SizedBox()
        ],
        title: const CustomText(
          text: 'All products',
          color: AppColors.primaryColor,
        ),
        backgroundColor: AppColors.secondColor,
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return provider.allProducts == null
            ? const Center(child: CustomText(text: "No product Found"))
            : GridView.builder(
                itemCount: provider.allProducts!.length,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height),
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (BuildContext context, int index) {
                  return ProductWidget(provider.allProducts![index]);
                },
              );
      }),
    );
  }
}
