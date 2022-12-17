import 'package:flutter/material.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:perfume_store/core/constant/colors.dart';
import 'package:provider/provider.dart';

import '../../component/app_text_field.dart';
import '../../models/category.dart';
import '../../providers/admin_provider.dart';

class EditCategory extends StatelessWidget {
  Category category;
  EditCategory(this.category, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "New Category",
          color: AppColors.primaryColor,
        ),
        backgroundColor: AppColors.secondColor,
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: provider.categoryFormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    provider.pickImage();
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15)),
                    child: provider.imageFile == null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              category.imageUrl,
                              fit: BoxFit.fill,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              provider.imageFile!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AppTextField(
                  controller: provider.catNameController,
                  hintText: 'Category name',
                  validation: provider.requiredValidation,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    provider.updateCategory(category);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.secondColor),
                    child: const Center(
                        child: CustomText(
                      text: "Update Category",
                      color: AppColors.primaryColor,
                      fontSize: 20,
                    )),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
