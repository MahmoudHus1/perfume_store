import 'package:flutter/material.dart';
import 'package:perfume_store/app_router/app_router.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:perfume_store/core/constant/colors.dart';
import 'package:perfume_store/models/category.dart';
import 'package:perfume_store/view/display_products.dart';
import 'package:provider/provider.dart';

import '../providers/admin_provider.dart';

// ignore: must_be_immutable
class CategoryWidget extends StatelessWidget {
  Category category;
  CategoryWidget(this.category, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Provider.of<AdminProvider>(context, listen: false).getAllProducts(category.id!);
        AppRouter.appRouter.goToWidget(AllProducts(catId: category.id,));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.primaryColor, width: 2)),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Image.network(
                        category.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    )),
                Positioned(
                    right: 15,
                    top: 10,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.secondColor,
                          child: IconButton(
                              onPressed: () {
                                Provider.of<AdminProvider>(context, listen: false)
                                  .deleteCategory(category);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: AppColors.primaryColor,
                                size: 30,
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.secondColor,
                          child: IconButton(
                              onPressed: () {
                                Provider.of<AdminProvider>(context, listen: false)
                                  .goToEditCategoryPage(category);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: AppColors.primaryColor,
                                size: 30,
                              )),
                        ),
                      ],
                    )),
              ],
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: Container(
                padding: const EdgeInsets.all(15),
                color: AppColors.secondColor,
                height: 70,
                child: Row(
                  children: [
                    const CustomText(
                      text: 'Category name : ',
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: category.name,
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
