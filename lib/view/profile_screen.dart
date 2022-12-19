import 'package:flutter/material.dart';
import 'package:perfume_store/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../component/custom_profile.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<AuthProvider>(
      builder: (context, provider, w) {
        return Container(
          margin: const EdgeInsets.only(top: 15),
          child: provider.loggedUser == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(80)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            (provider.loggedUser?.imageUrl)!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomProfile(
                        label: "User name : ",
                        value: provider.loggedUser!.userName,
                      ),
                      CustomProfile(
                        label: "User email : ",
                        value: provider.loggedUser!.email,
                      ),
                      CustomProfile(
                        label: "User phone :",
                        value: provider.loggedUser!.phoneNumber,
                      ),
                    ],
                  ),
                ),
        );
      },
    ));
  }
}
