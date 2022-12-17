import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../component/custom_profile.dart';
import '../../providers/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<AuthProvider>(
          builder: (context, provider, w) {
            return Container(
              color: Colors.grey.withOpacity(0.2),
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
                          GestureDetector(
                            onTap: () {
                              provider.uploadNewFile();
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration:  BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: provider.loggedUser?.imageUrl == ''
                                  ? const Center(
                                      child: Icon(Icons.person, size: 80,),
                                    )
                                  : 
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                        (provider.loggedUser?.imageUrl)!,
                                        fit: BoxFit.fill,
                                      ),
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
