import 'package:flutter/material.dart';
import 'package:perfume_store/app_router/app_router.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:perfume_store/core/constant/colors.dart';
import 'package:perfume_store/providers/admin_provider.dart';
import 'package:perfume_store/providers/auth_provider.dart';
import 'package:perfume_store/view/display_products.dart';
import 'package:perfume_store/view/product_detiles.dart';
import 'package:provider/provider.dart';

class UserInterface extends StatelessWidget {
  const UserInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: AppColors.primaryColor,
              ))
        ],
        title: const CustomText(
          text: 'All products',
          color: AppColors.primaryColor,
        ),
        backgroundColor: AppColors.secondColor,
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, index) {
        if (!provider.getData) {
          provider.menProducts =[];
          provider.womenProducts =[];
          provider.getMenAndWomenProducts();
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _searchTextFormField(),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CustomText(
                        text: "Categories",
                        color: AppColors.secondColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    CustomText(
                      text: "See all",
                      color: AppColors.secondColor,
                      fontSize: 16,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.allCategories!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            provider.getAllProducts(provider.allCategories![index].id!);
                            AppRouter.appRouter.goToWidget(AllProducts(
                                catId: provider.allCategories![index].id));
                          },
                          child: Column(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          provider
                                              .allCategories![index].imageUrl,
                                          fit: BoxFit.fill,
                                        ))),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: CustomText(
                                  text: provider.allCategories![index].name,
                                  color: AppColors.secondColor,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CustomText(
                      text: "Best Men Perfums Selling",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondColor,
                    ),
                    CustomText(
                      text: "See all",
                      color: AppColors.secondColor,
                      fontSize: 16,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  height: 300,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.menProducts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            AppRouter.appRouter.goToWidget(
                              ProductDetiles(
                                product: provider.menProducts[index],
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          provider.menProducts[index].imageUrl,
                                          fit: BoxFit.fill,
                                        ))),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: CustomText(
                                  text: provider.menProducts[index].name,
                                  color: AppColors.secondColor,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CustomText(
                      text: "Best Women Perfums Selling",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondColor,
                    ),
                    CustomText(
                      text: "See all",
                      color: AppColors.secondColor,
                      fontSize: 16,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  height: 300,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.womenProducts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductDetiles(
                                  product: provider.womenProducts[index],
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          provider
                                              .womenProducts[index].imageUrl,
                                          fit: BoxFit.fill,
                                        ))),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: CustomText(
                                  text: provider.womenProducts[index].name,
                                  color: AppColors.secondColor,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _searchTextFormField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.secondColor.withOpacity(0.8)),
      child: TextFormField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search_outlined,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
