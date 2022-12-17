
import 'package:flutter/material.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:perfume_store/core/constant/colors.dart';
import 'package:provider/provider.dart';

import '../../app_router/app_router.dart';
import '../../component/category_widget.dart';
import '../../providers/admin_provider.dart';
import 'add_category.dart';

class AllCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.appRouter.goToWidget(AddNewCategory());
              },
              icon: const Icon(Icons.add,color :AppColors.primaryColor))
        ],
        title: const CustomText(text: "All Categories", color: AppColors.primaryColor,fontWeight: FontWeight.bold,)
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return provider.allCategories == null
            ? const Center(
                child: CustomText(text: "No Categories Found")
              )
            : ListView.builder(
                itemCount: provider.allCategories!.length,
                itemBuilder: (context, index) {
                  return CategoryWidget(provider.allCategories![index]);
                });
      }),
    );
  }
}