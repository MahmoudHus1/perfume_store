import 'package:flutter/material.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:perfume_store/core/constant/colors.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class MyHeaderDrawer extends StatelessWidget {
  const MyHeaderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, w) {
      return Container(
        width: double.infinity,
        color: AppColors.secondColor,
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 100,
                child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    height: 100,
                    width: 100,
                    child: provider.loggedUser?.imageUrl == ''
                        ? const Center(
                            child: Icon(
                              Icons.person,
                              size: 70,
                            ),
                          )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(300.0),
                          child: Image.network(
                            (provider.loggedUser?.imageUrl)!,
                            fit: BoxFit.fill,
                          ),
                        ))),
            CustomText(
              text: provider.loggedUser!.userName,
              fontSize: 20,
              color: AppColors.primaryColor,
            ),
            CustomText(
                text: provider.loggedUser!.email,
                fontSize: 16,
                color: AppColors.primaryColor),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
    });
  }
}
