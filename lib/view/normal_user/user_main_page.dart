import 'package:flutter/material.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:perfume_store/core/constant/colors.dart';
import 'package:perfume_store/providers/admin_provider.dart';
import 'package:provider/provider.dart';

import '../../data_repositories/firestore_helper.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const CustomText(text: "Normal user"),
          backgroundColor: AppColors.secondColor,
        ),
        body: Consumer<AdminProvider>(builder: (context, provider, index) {
          return GridView.builder(
            itemCount: provider.allCategories!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                width: 100,
                child: Image.network(
                  provider.allCategories![index].imageUrl,
                  fit: BoxFit.fill,
                ),
              );
            },
          );
        }));
  }
}
