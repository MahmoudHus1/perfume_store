import 'package:flutter/material.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:provider/provider.dart';

import '../../component/app_text_field.dart';
import '../../component/custom_button.dart';
import '../../core/constant/colors.dart';
import '../../providers/admin_provider.dart';

class AddNewCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.secondColor,
          title: const CustomText(
            text: "New Category",
            color: AppColors.primaryColor,
          )),
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
                        ? const Center(
                            child: Icon(
                              Icons.add,
                              size: 50,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
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
                  icon: Icons.category_outlined,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    provider.addNewCategory();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.secondColor),
                    child: const Center(
                        child: CustomText(
                      text: "Add new category",
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
