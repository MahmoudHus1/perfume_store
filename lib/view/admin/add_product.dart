import 'package:flutter/material.dart';
import 'package:perfume_store/component/app_text_field.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:provider/provider.dart';

import '../../component/custom_button.dart';
import '../../core/constant/colors.dart';
import '../../providers/admin_provider.dart';

class AddNewProduct extends StatelessWidget {
  String catId;
  AddNewProduct(this.catId, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
                    onTap: () {
                      Provider.of<AdminProvider>(context).addNewProduct(catId);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.secondColor),
                      child: const Center(
                          child: CustomText(
                        text: "Add new product",
                        color: AppColors.primaryColor,
                        fontSize: 20,
                      )),
                    ),
                  ),
      appBar: AppBar(
        title: const CustomText(
          text: "Add New Product",
          color: AppColors.primaryColor,
        ),
        backgroundColor: AppColors.secondColor,
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: provider.productKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const CustomText(
                            text: "Choose ingredients",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondColor,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              provider.pickIngredientImage();
                            },
                            child: Container(
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: provider.ingredientFile == null
                                  ? const Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 50,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        provider.ingredientFile!,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const CustomText(
                            text: "Choose Perfume",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondColor,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              provider.pickImage();
                            },
                            child: Container(
                              height: 180,
                              width: 180,
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
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        provider.imageFile!,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AppTextField(
                    controller: provider.productNameController,
                    hintText: 'Product name',
                    validation: provider.requiredValidation,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    controller: provider.productDescriptionController,
                    hintText: 'Product Description',
                    validation: provider.requiredValidation,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    controller: provider.productPriceController,
                    hintText: 'Product Price',
                    validation: provider.requiredValidation,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
